import SwiftUI
import SwiftData

enum HistoryViewMode: String, CaseIterable {
    case simple = "Simple"
    case detailed = "Detailed"
}

struct HistoryDetailView: View {
    let session: WorkoutSession
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteAlert = false
    @State private var viewMode: HistoryViewMode = .simple

    private var groupedSets: [(String, [ExerciseSet])] {
        let grouped = Dictionary(grouping: session.exerciseSets) { $0.exerciseName }
        return grouped.sorted { first, second in
            let firstMinSet = first.value.min(by: { $0.setNumber < $1.setNumber })?.setNumber ?? 0
            let secondMinSet = second.value.min(by: { $0.setNumber < $1.setNumber })?.setNumber ?? 0
            return firstMinSet < secondMinSet
        }
    }

    private var exerciseCount: Int {
        Set(session.exerciseSets.map { $0.exerciseName }).count
    }

    var body: some View {
        List {
            // Summary Section
            Section {
                VStack(spacing: 16) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(session.workoutPlanName)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(session.formattedDate)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()

                        // Difficulty feedback badge if present
                        if let feedback = session.feedback {
                            Text(feedback.emoji)
                                .font(.title2)
                        }
                    }

                    HStack(spacing: 16) {
                        StatItem(title: "Duration", value: session.formattedDuration, icon: "clock.fill")
                        StatItem(title: "Exercises", value: "\(exerciseCount)", icon: "list.bullet")
                        StatItem(title: "Sets", value: "\(session.totalSets)", icon: "checkmark.circle.fill")
                        StatItem(title: "Volume", value: formatVolume(session.totalVolume), icon: "scalemass.fill")
                    }
                }
                .padding(.vertical, 8)
            }

            // View Mode Picker
            Section {
                Picker("View Mode", selection: $viewMode) {
                    ForEach(HistoryViewMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
            }

            // Exercise Details based on view mode
            if viewMode == .simple {
                simpleExerciseView
            } else {
                detailedExerciseView
            }

            // Delete Section
            Section {
                Button(role: .destructive) {
                    showingDeleteAlert = true
                } label: {
                    HStack {
                        Spacer()
                        Label("Delete Workout", systemImage: "trash")
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Workout?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                modelContext.delete(session)
                dismiss()
            }
        } message: {
            Text("This action cannot be undone.")
        }
    }

    // MARK: - Simple View
    private var simpleExerciseView: some View {
        Section("Exercises") {
            ForEach(groupedSets, id: \.0) { exerciseName, sets in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(exerciseName)
                            .font(.headline)

                        let totalReps = sets.reduce(0) { $0 + $1.reps }
                        let maxWeight = sets.map { $0.weight }.max() ?? 0

                        Text("\(sets.count) sets • \(totalReps) reps • Max \(Int(maxWeight)) lbs")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    // Show PR badge if best weight
                    let volume = sets.reduce(0.0) { $0 + ($1.weight * Double($1.reps)) }
                    Text(formatVolume(volume))
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.blue)
                }
                .padding(.vertical, 4)
            }
        }
    }

    // MARK: - Detailed View
    private var detailedExerciseView: some View {
        ForEach(groupedSets, id: \.0) { exerciseName, sets in
            Section(exerciseName) {
                ForEach(sets.sorted(by: { $0.setNumber < $1.setNumber })) { set in
                    HStack {
                        Text("Set \(set.setNumber)")
                            .foregroundStyle(.secondary)
                            .frame(width: 50, alignment: .leading)

                        Spacer()

                        Text("\(set.reps) reps")
                            .fontWeight(.medium)

                        Text("×")
                            .foregroundStyle(.secondary)

                        Text("\(Int(set.weight)) lbs")
                            .fontWeight(.medium)
                            .foregroundStyle(.blue)
                            .frame(width: 70, alignment: .trailing)

                        // Volume for this set
                        Text("= \(Int(set.weight * Double(set.reps)))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(width: 60, alignment: .trailing)
                    }
                }

                // Exercise summary row
                HStack {
                    Text("Total")
                        .fontWeight(.semibold)

                    Spacer()

                    let totalReps = sets.reduce(0) { $0 + $1.reps }
                    let avgWeight = sets.isEmpty ? 0 : sets.reduce(0.0) { $0 + $1.weight } / Double(sets.count)
                    let totalVolume = sets.reduce(0.0) { $0 + ($1.weight * Double($1.reps)) }

                    Text("\(totalReps) reps")
                        .foregroundStyle(.secondary)

                    Text("•")
                        .foregroundStyle(.secondary)

                    Text("Avg \(Int(avgWeight)) lbs")
                        .foregroundStyle(.secondary)

                    Text("•")
                        .foregroundStyle(.secondary)

                    Text(formatVolume(totalVolume) + " vol")
                        .foregroundStyle(.blue)
                        .fontWeight(.medium)
                }
                .font(.caption)
                .padding(.top, 4)
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

struct StatItem: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.blue)

            Text(value)
                .font(.headline)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: WorkoutSession.self, ExerciseSet.self, configurations: config)

    let sets = [
        ExerciseSet(exerciseName: "Bench Press", setNumber: 1, reps: 10, weight: 135),
        ExerciseSet(exerciseName: "Bench Press", setNumber: 2, reps: 8, weight: 155),
        ExerciseSet(exerciseName: "Bench Press", setNumber: 3, reps: 6, weight: 175),
        ExerciseSet(exerciseName: "Overhead Press", setNumber: 1, reps: 10, weight: 95),
        ExerciseSet(exerciseName: "Overhead Press", setNumber: 2, reps: 8, weight: 95),
    ]

    let session = WorkoutSession(
        date: Date(),
        workoutPlanName: "Push Day",
        duration: 2700,
        exerciseSets: sets
    )

    container.mainContext.insert(session)

    return NavigationStack {
        HistoryDetailView(session: session)
    }
    .modelContainer(container)
}
