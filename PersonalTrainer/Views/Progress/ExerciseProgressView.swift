import SwiftUI
import SwiftData
import Charts

enum ProgressTimeRange: String, CaseIterable {
    case month = "30 Days"
    case threeMonths = "3 Months"
    case year = "Year"
    case allTime = "All Time"

    var days: Int? {
        switch self {
        case .month: return 30
        case .threeMonths: return 90
        case .year: return 365
        case .allTime: return nil
        }
    }
}

enum ProgressMetric: String, CaseIterable {
    case weight = "Max Weight"
    case volume = "Volume"
    case reps = "Total Reps"
    case estimated1RM = "Est. 1RM"

    var icon: String {
        switch self {
        case .weight: return "scalemass.fill"
        case .volume: return "chart.bar.fill"
        case .reps: return "number"
        case .estimated1RM: return "trophy.fill"
        }
    }
}

struct ExerciseProgressData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
    let metric: ProgressMetric
}

struct ExerciseProgressView: View {
    let exerciseName: String
    @Query(sort: \WorkoutSession.date, order: .forward) private var allSessions: [WorkoutSession]

    @State private var selectedTimeRange: ProgressTimeRange = .threeMonths
    @State private var selectedMetric: ProgressMetric = .weight

    private var filteredSessions: [WorkoutSession] {
        let cutoffDate: Date
        if let days = selectedTimeRange.days {
            cutoffDate = Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
        } else {
            cutoffDate = Date.distantPast
        }
        return allSessions.filter { $0.date >= cutoffDate }
    }

    private var exerciseData: [ExerciseProgressData] {
        var data: [ExerciseProgressData] = []

        for session in filteredSessions {
            let exerciseSets = session.exerciseSets.filter { $0.exerciseName == exerciseName }
            guard !exerciseSets.isEmpty else { continue }

            let value: Double
            switch selectedMetric {
            case .weight:
                value = exerciseSets.map { $0.weight }.max() ?? 0
            case .volume:
                value = exerciseSets.reduce(0) { $0 + ($1.weight * Double($1.reps)) }
            case .reps:
                value = Double(exerciseSets.reduce(0) { $0 + $1.reps })
            case .estimated1RM:
                // Epley formula: 1RM = weight × (1 + reps/30)
                let best1RM = exerciseSets.map { set -> Double in
                    set.weight * (1 + Double(set.reps) / 30.0)
                }.max() ?? 0
                value = best1RM
            }

            if value > 0 {
                data.append(ExerciseProgressData(date: session.date, value: value, metric: selectedMetric))
            }
        }

        return data.sorted { $0.date < $1.date }
    }

    private var personalRecords: (maxWeight: Double, maxVolume: Double, max1RM: Double) {
        var maxWeight: Double = 0
        var maxVolume: Double = 0
        var max1RM: Double = 0

        for session in allSessions {
            let exerciseSets = session.exerciseSets.filter { $0.exerciseName == exerciseName }
            for set in exerciseSets {
                maxWeight = max(maxWeight, set.weight)
                let volume = set.weight * Double(set.reps)
                maxVolume = max(maxVolume, volume)
                let oneRM = set.weight * (1 + Double(set.reps) / 30.0)
                max1RM = max(max1RM, oneRM)
            }
        }

        return (maxWeight, maxVolume, max1RM)
    }

    private var yAxisLabel: String {
        switch selectedMetric {
        case .weight, .estimated1RM: return "Weight (lbs)"
        case .volume: return "Volume (lbs)"
        case .reps: return "Reps"
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Personal Records Section
                personalRecordsSection

                // Time Range Picker
                Picker("Time Range", selection: $selectedTimeRange) {
                    ForEach(ProgressTimeRange.allCases, id: \.self) { range in
                        Text(range.rawValue).tag(range)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // Metric Picker
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(ProgressMetric.allCases, id: \.self) { metric in
                            MetricButton(
                                metric: metric,
                                isSelected: selectedMetric == metric
                            ) {
                                withAnimation {
                                    selectedMetric = metric
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Chart
                if exerciseData.isEmpty {
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

    // MARK: - Personal Records Section
    private var personalRecordsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Personal Records")
                .font(.headline)
                .padding(.horizontal)

            HStack(spacing: 12) {
                PRCard(
                    title: "Max Weight",
                    value: "\(Int(personalRecords.maxWeight))",
                    unit: "lbs",
                    icon: "scalemass.fill",
                    color: .blue
                )

                PRCard(
                    title: "Est. 1RM",
                    value: "\(Int(personalRecords.max1RM))",
                    unit: "lbs",
                    icon: "trophy.fill",
                    color: .yellow
                )

                PRCard(
                    title: "Best Volume",
                    value: formatVolume(personalRecords.maxVolume),
                    unit: "",
                    icon: "chart.bar.fill",
                    color: .green
                )
            }
            .padding(.horizontal)
        }
    }

    // MARK: - Chart View
    private var chartView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(selectedMetric.rawValue + " Over Time")
                .font(.headline)
                .padding(.horizontal)

            Chart(exerciseData) { dataPoint in
                LineMark(
                    x: .value("Date", dataPoint.date),
                    y: .value(yAxisLabel, dataPoint.value)
                )
                .foregroundStyle(Color.blue.gradient)
                .interpolationMethod(.catmullRom)

                AreaMark(
                    x: .value("Date", dataPoint.date),
                    y: .value(yAxisLabel, dataPoint.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.05)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .interpolationMethod(.catmullRom)

                PointMark(
                    x: .value("Date", dataPoint.date),
                    y: .value(yAxisLabel, dataPoint.value)
                )
                .foregroundStyle(Color.blue)
                .symbolSize(30)
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day, count: selectedTimeRange == .month ? 7 : 30)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month(.abbreviated).day())
                }
            }
            .chartYAxis {
                AxisMarks { value in
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
            .frame(height: 250)
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
        .frame(height: 250)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .padding(.horizontal)
    }

    // MARK: - History List
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
                    let sets = session.exerciseSets.filter { $0.exerciseName == exerciseName }
                    SessionExerciseRow(session: session, sets: sets)
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

// MARK: - Supporting Views

struct MetricButton: View {
    let metric: ProgressMetric
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: metric.icon)
                Text(metric.rawValue)
            }
            .font(.subheadline)
            .fontWeight(isSelected ? .semibold : .regular)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(isSelected ? Color.blue : Color(.systemGray5))
            .foregroundStyle(isSelected ? .white : .primary)
            .cornerRadius(20)
        }
        .buttonStyle(.plain)
    }
}

struct PRCard: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            if !unit.isEmpty {
                Text(unit)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct SessionExerciseRow: View {
    let session: WorkoutSession
    let sets: [ExerciseSet]

    private var maxWeight: Double {
        sets.map { $0.weight }.max() ?? 0
    }

    private var totalReps: Int {
        sets.reduce(0) { $0 + $1.reps }
    }

    private var totalVolume: Double {
        sets.reduce(0) { $0 + ($1.weight * Double($1.reps)) }
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
                Label(formatVolume(totalVolume), systemImage: "chart.bar")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            // Show individual sets
            HStack(spacing: 8) {
                ForEach(sets.sorted { $0.setNumber < $1.setNumber }) { set in
                    Text("\(set.reps)×\(Int(set.weight))")
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .foregroundStyle(.blue)
                        .cornerRadius(6)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    private func formatVolume(_ volume: Double) -> String {
        if volume >= 1000 {
            return String(format: "%.1fk", volume / 1000)
        }
        return "\(Int(volume))"
    }
}

#Preview {
    NavigationStack {
        ExerciseProgressView(exerciseName: "Bench Press")
    }
    .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
