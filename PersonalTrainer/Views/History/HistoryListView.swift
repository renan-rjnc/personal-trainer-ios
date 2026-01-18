import SwiftUI
import SwiftData
import Charts

struct HistoryListView: View {
    @Query(sort: \WorkoutSession.date, order: .reverse) private var sessions: [WorkoutSession]
    @Environment(\.modelContext) private var modelContext

    // Get all unique exercise names from history
    private var uniqueExerciseNames: [String] {
        let allNames = sessions.flatMap { $0.exerciseSets.map { $0.exerciseName } }
        return Array(Set(allNames)).sorted()
    }

    private var groupedSessions: [(String, [WorkoutSession])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: sessions) { session -> String in
            if calendar.isDateInToday(session.date) {
                return "Today"
            } else if calendar.isDateInYesterday(session.date) {
                return "Yesterday"
            } else if calendar.isDate(session.date, equalTo: Date(), toGranularity: .weekOfYear) {
                return "This Week"
            } else if calendar.isDate(session.date, equalTo: Date(), toGranularity: .month) {
                return "This Month"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM yyyy"
                return formatter.string(from: session.date)
            }
        }

        let order = ["Today", "Yesterday", "This Week", "This Month"]
        return grouped.sorted { first, second in
            let firstIndex = order.firstIndex(of: first.key) ?? Int.max
            let secondIndex = order.firstIndex(of: second.key) ?? Int.max
            if firstIndex != secondIndex {
                return firstIndex < secondIndex
            }
            return first.value.first?.date ?? Date() > second.value.first?.date ?? Date()
        }
    }

    // Summary stats
    private var totalWorkouts: Int { sessions.count }
    private var totalVolume: Double {
        sessions.reduce(0) { $0 + $1.totalVolume }
    }
    private var totalDuration: TimeInterval {
        sessions.reduce(0) { $0 + $1.duration }
    }

    var body: some View {
        NavigationStack {
            Group {
                if sessions.isEmpty {
                    emptyStateView
                } else {
                    sessionsList
                }
            }
            .navigationTitle("History")
        }
    }

    private var sessionsList: some View {
        List {
            // Summary Stats Section
            Section {
                HStack(spacing: 16) {
                    SummaryStatCard(title: "Workouts", value: "\(totalWorkouts)", icon: "flame.fill", color: .orange)
                    SummaryStatCard(title: "Volume", value: formatVolume(totalVolume), icon: "scalemass.fill", color: .blue)
                    SummaryStatCard(title: "Time", value: formatTotalTime(totalDuration), icon: "clock.fill", color: .green)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }

            // Progress Reports Section
            Section("Progress Reports") {
                NavigationLink(destination: ExerciseSelectionView(exerciseNames: uniqueExerciseNames)) {
                    ProgressReportsRow()
                }
            }

            // Workout History
            ForEach(groupedSessions, id: \.0) { item in
                Section(item.0) {
                    ForEach(item.1) { session in
                        NavigationLink(destination: HistoryDetailView(session: session)) {
                            HistoryRowView(session: session)
                        }
                    }
                    .onDelete { indexSet in
                        deleteSession(in: item.1, at: indexSet)
                    }
                }
            }
        }
    }

    private func formatVolume(_ volume: Double) -> String {
        if volume >= 1_000_000 {
            return String(format: "%.1fM", volume / 1_000_000)
        } else if volume >= 1000 {
            return String(format: "%.1fk", volume / 1000)
        }
        return "\(Int(volume))"
    }

    private func formatTotalTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        if hours > 0 {
            return "\(hours)h"
        }
        let minutes = Int(time) / 60
        return "\(minutes)m"
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "clock.badge.questionmark")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)

            Text("No Workouts Yet")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Complete your first workout to see it here")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    private func deleteSession(in groupSessions: [WorkoutSession], at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(groupSessions[index])
        }
    }
}

// MARK: - Progress Reports Row
struct ProgressReportsRow: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 44, height: 44)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text("Exercise Progress")
                    .font(.headline)

                Text("View graphs and PRs for each exercise")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - History Row View
struct HistoryRowView: View {
    let session: WorkoutSession

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(session.workoutPlanName)
                    .font(.headline)

                Text(session.formattedDate)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(session.formattedDuration)
                    .font(.headline)
                    .foregroundStyle(.blue)

                Text("\(session.totalSets) sets")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Summary Stat Card
struct SummaryStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)

            Text(value)
                .font(.headline)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Exercise Selection View
struct ExerciseSelectionView: View {
    let exerciseNames: [String]
    @State private var searchText = ""

    private var filteredExercises: [String] {
        if searchText.isEmpty {
            return exerciseNames
        }
        return exerciseNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        List {
            if filteredExercises.isEmpty {
                emptyView
            } else {
                exercisesList
            }
        }
        .navigationTitle("Exercise Progress")
        .searchable(text: $searchText, prompt: "Search exercises")
    }

    private var emptyView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)

            Text("No exercises found")
                .font(.headline)

            Text("Complete workouts to see exercises here")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .listRowBackground(Color.clear)
    }

    private var exercisesList: some View {
        ForEach(filteredExercises, id: \.self) { exerciseName in
            NavigationLink(destination: ExerciseProgressView(exerciseName: exerciseName)) {
                ProgressExerciseRowView(exerciseName: exerciseName)
            }
        }
    }
}

// MARK: - Progress Exercise Row View
struct ProgressExerciseRowView: View {
    let exerciseName: String

    var body: some View {
        HStack {
            Image(systemName: "figure.strengthtraining.traditional")
                .foregroundStyle(.blue)
                .frame(width: 30)

            Text(exerciseName)
        }
    }
}

// MARK: - Exercise Progress View
struct ExerciseProgressView: View {
    let exerciseName: String
    @Query(sort: \WorkoutSession.date, order: .forward) private var allSessions: [WorkoutSession]

    @State private var selectedTimeRange: Int = 90 // days

    private var filteredSessions: [WorkoutSession] {
        let cutoffDate = Calendar.current.date(byAdding: .day, value: -selectedTimeRange, to: Date()) ?? Date()
        return allSessions.filter { $0.date >= cutoffDate }
    }

    private var chartData: [(date: Date, weight: Double)] {
        var data: [(Date, Double)] = []
        for session in filteredSessions {
            let exerciseSets = session.exerciseSets.filter { $0.exerciseName == exerciseName }
            if let maxWeight = exerciseSets.map({ $0.weight }).max(), maxWeight > 0 {
                data.append((session.date, maxWeight))
            }
        }
        return data.sorted { $0.0 < $1.0 }
    }

    private var personalRecords: (maxWeight: Double, maxVolume: Double) {
        var maxWeight: Double = 0
        var maxVolume: Double = 0

        for session in allSessions {
            let exerciseSets = session.exerciseSets.filter { $0.exerciseName == exerciseName }
            for set in exerciseSets {
                maxWeight = max(maxWeight, set.weight)
                let volume = set.weight * Double(set.reps)
                maxVolume = max(maxVolume, volume)
            }
        }

        return (maxWeight, maxVolume)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Personal Records Section
                personalRecordsSection

                // Time Range Picker
                Picker("Time Range", selection: $selectedTimeRange) {
                    Text("30 Days").tag(30)
                    Text("3 Months").tag(90)
                    Text("1 Year").tag(365)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // Chart
                if chartData.isEmpty {
                    emptyChartView
                } else {
                    chartView
                }

                // History List
                historyListSection
            }
            .padding(.vertical)
        }
        .navigationTitle(exerciseName)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var personalRecordsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Personal Records")
                .font(.headline)
                .padding(.horizontal)

            HStack(spacing: 12) {
                PRCard(title: "Max Weight", value: "\(Int(personalRecords.maxWeight))", unit: "lbs", color: .blue)
                PRCard(title: "Best Volume", value: formatVolume(personalRecords.maxVolume), unit: "", color: .green)
            }
            .padding(.horizontal)
        }
    }

    private var chartView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Weight Over Time")
                .font(.headline)
                .padding(.horizontal)

            Chart {
                ForEach(chartData, id: \.date) { item in
                    LineMark(
                        x: .value("Date", item.date),
                        y: .value("Weight", item.weight)
                    )
                    .foregroundStyle(Color.blue)

                    PointMark(
                        x: .value("Date", item.date),
                        y: .value("Weight", item.weight)
                    )
                    .foregroundStyle(Color.blue)
                }
            }
            .frame(height: 200)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .padding(.horizontal)
        }
    }

    private var emptyChartView: some View {
        VStack(spacing: 16) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.system(size: 50))
                .foregroundStyle(.secondary)

            Text("No Data Available")
                .font(.headline)

            Text("Complete workouts with this exercise to see your progress")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .padding(.horizontal)
    }

    private var historyListSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Sessions")
                .font(.headline)
                .padding(.horizontal)

            let sessionsWithExercise = filteredSessions.filter { session in
                session.exerciseSets.contains { $0.exerciseName == exerciseName }
            }.sorted { $0.date > $1.date }

            if sessionsWithExercise.isEmpty {
                Text("No sessions found for this exercise")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            } else {
                ForEach(sessionsWithExercise.prefix(10)) { session in
                    SessionExerciseRowView(session: session, exerciseName: exerciseName)
                        .padding(.horizontal)
                }
            }
        }
    }

    private func formatVolume(_ volume: Double) -> String {
        if volume >= 1000 {
            return String(format: "%.1fk", volume / 1000)
        }
        return "\(Int(volume))"
    }
}

// MARK: - PR Card
struct PRCard: View {
    let title: String
    let value: String
    let unit: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(color)

            if !unit.isEmpty {
                Text(unit)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Session Exercise Row View
struct SessionExerciseRowView: View {
    let session: WorkoutSession
    let exerciseName: String

    private var sets: [ExerciseSet] {
        session.exerciseSets.filter { $0.exerciseName == exerciseName }
    }

    private var maxWeight: Double {
        sets.map { $0.weight }.max() ?? 0
    }

    private var totalReps: Int {
        sets.reduce(0) { $0 + $1.reps }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(session.formattedDate)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Spacer()

                Text("\(sets.count) sets")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 16) {
                Label("\(Int(maxWeight)) lbs", systemImage: "scalemass")
                Label("\(totalReps) reps", systemImage: "number")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    HistoryListView()
        .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
