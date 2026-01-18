import SwiftUI
import SwiftData

struct HistoryListView: View {
    @Query(sort: \WorkoutSession.date, order: .reverse) private var sessions: [WorkoutSession]
    @Environment(\.modelContext) private var modelContext
    @State private var showingProgressReports = false

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
                    List {
                        // Summary Stats Section
                        Section {
                            HStack(spacing: 16) {
                                SummaryStatCard(
                                    title: "Workouts",
                                    value: "\(totalWorkouts)",
                                    icon: "flame.fill",
                                    color: .orange
                                )
                                SummaryStatCard(
                                    title: "Volume",
                                    value: formatVolume(totalVolume),
                                    icon: "scalemass.fill",
                                    color: .blue
                                )
                                SummaryStatCard(
                                    title: "Time",
                                    value: formatTotalTime(totalDuration),
                                    icon: "clock.fill",
                                    color: .green
                                )
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                        }

                        // Progress Reports Section
                        Section("Progress Reports") {
                            NavigationLink(destination: ExerciseSelectionView(exerciseNames: uniqueExerciseNames)) {
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

                        // Workout History
                        ForEach(groupedSessions, id: \.0) { group, groupSessions in
                            Section(group) {
                                ForEach(groupSessions) { session in
                                    NavigationLink(destination: HistoryDetailView(session: session)) {
                                        HistoryRowView(session: session)
                                    }
                                }
                                .onDelete { indexSet in
                                    deleteSession(in: groupSessions, at: indexSet)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
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

    // Group exercises by muscle group (simplified)
    private var groupedExercises: [(String, [String])] {
        let muscleGroupMap: [String: String] = [
            "Bench Press": "Chest",
            "Incline Dumbbell Press": "Chest",
            "Dumbbell Flyes": "Chest",
            "Push-Ups": "Chest",
            "Cable Crossover": "Chest",
            "Deadlift": "Back",
            "Pull-Ups": "Back",
            "Barbell Rows": "Back",
            "Lat Pulldown": "Back",
            "Seated Cable Row": "Back",
            "Dumbbell Rows": "Back",
            "Overhead Press": "Shoulders",
            "Lateral Raises": "Shoulders",
            "Front Raises": "Shoulders",
            "Arnold Press": "Shoulders",
            "Face Pulls": "Shoulders",
            "Reverse Flyes": "Shoulders",
            "Bicep Curls": "Arms",
            "Hammer Curls": "Arms",
            "Preacher Curls": "Arms",
            "Incline Dumbbell Curls": "Arms",
            "Tricep Dips": "Arms",
            "Tricep Pushdown": "Arms",
            "Skull Crushers": "Arms",
            "Overhead Tricep Extension": "Arms",
            "Barbell Squats": "Legs",
            "Leg Press": "Legs",
            "Leg Extensions": "Legs",
            "Walking Lunges": "Legs",
            "Bulgarian Split Squats": "Legs",
            "Goblet Squats": "Legs",
            "Romanian Deadlift": "Legs",
            "Leg Curls": "Legs",
            "Hip Thrusts": "Legs",
            "Glute Bridges": "Legs",
            "Good Mornings": "Legs",
            "Calf Raises": "Legs",
            "Seated Calf Raises": "Legs",
            "Planks": "Core",
            "Cable Crunches": "Core",
            "Hanging Leg Raises": "Core",
            "Russian Twists": "Core"
        ]

        var grouped: [String: [String]] = [:]
        for exercise in filteredExercises {
            let group = muscleGroupMap[exercise] ?? "Other"
            grouped[group, default: []].append(exercise)
        }

        let order = ["Chest", "Back", "Shoulders", "Arms", "Legs", "Core", "Other"]
        return order.compactMap { group in
            guard let exercises = grouped[group], !exercises.isEmpty else { return nil }
            return (group, exercises.sorted())
        }
    }

    var body: some View {
        List {
            if filteredExercises.isEmpty {
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
            } else {
                ForEach(groupedExercises, id: \.0) { group, exercises in
                    Section(group) {
                        ForEach(exercises, id: \.self) { exerciseName in
                            NavigationLink(destination: ExerciseProgressView(exerciseName: exerciseName)) {
                                HStack {
                                    Image(systemName: iconForGroup(group))
                                        .foregroundStyle(.blue)
                                        .frame(width: 30)

                                    Text(exerciseName)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Exercise Progress")
        .searchable(text: $searchText, prompt: "Search exercises")
    }

    private func iconForGroup(_ group: String) -> String {
        switch group {
        case "Chest": return "figure.arms.open"
        case "Back": return "figure.strengthtraining.traditional"
        case "Shoulders": return "figure.arms.open"
        case "Arms": return "figure.strengthtraining.traditional"
        case "Legs": return "figure.walk"
        case "Core": return "figure.core.training"
        default: return "figure.mixed.cardio"
        }
    }
}

#Preview {
    HistoryListView()
        .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
