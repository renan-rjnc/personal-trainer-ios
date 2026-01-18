import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    let workout: WorkoutPlan
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    @Query(sort: \WorkoutSession.date, order: .reverse) private var sessions: [WorkoutSession]

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: workout.iconName)
                            .font(.largeTitle)
                            .foregroundStyle(.blue)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(workout.name)
                                .font(.title)
                                .fontWeight(.bold)

                            Text(workout.description)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }

                    HStack(spacing: 20) {
                        Label("\(workout.exercises.count) exercises", systemImage: "list.bullet")
                        Label("\(workout.estimatedDuration) min", systemImage: "clock")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }

            Section("Exercises") {
                ForEach(Array(workout.exercises.enumerated()), id: \.element.id) { index, exercise in
                    NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                        ExerciseRowView(exercise: exercise, index: index + 1)
                    }
                }
            }

            Section {
                Button(action: {
                    workoutViewModel.startWorkout(plan: workout, pastSessions: sessions)
                }) {
                    HStack {
                        Spacer()
                        Label("Start Workout", systemImage: "play.fill")
                            .font(.headline)
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $workoutViewModel.isWorkoutActive) {
            ActiveWorkoutView(
                workoutViewModel: workoutViewModel,
                timerViewModel: timerViewModel,
                workout: workout
            )
        }
    }
}

struct ExerciseRowView: View {
    let exercise: Exercise
    let index: Int

    var body: some View {
        HStack(spacing: 12) {
            Text("\(index)")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 28, height: 28)
                .background(Color.blue)
                .cornerRadius(6)

            VStack(alignment: .leading, spacing: 2) {
                Text(exercise.name)
                    .font(.headline)

                Text(exercise.muscleGroups.joined(separator: ", "))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("\(exercise.defaultSets) sets")
                    .font(.subheadline)
                Text("\(exercise.defaultReps) reps")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        WorkoutDetailView(
            workout: SampleWorkouts.pushDay,
            workoutViewModel: WorkoutViewModel(),
            timerViewModel: TimerViewModel()
        )
    }
    .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
