import SwiftUI

struct WorkoutListView: View {
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    let workouts = SampleWorkouts.allWorkouts

    var body: some View {
        NavigationStack {
            List(workouts) { workout in
                NavigationLink(destination: WorkoutDetailView(
                    workout: workout,
                    workoutViewModel: workoutViewModel,
                    timerViewModel: timerViewModel
                )) {
                    WorkoutRowView(workout: workout)
                }
            }
            .navigationTitle("Workouts")
            .fullScreenCover(isPresented: $workoutViewModel.isWorkoutActive) {
                if let workout = workoutViewModel.currentWorkout {
                    ActiveWorkoutView(
                        workoutViewModel: workoutViewModel,
                        timerViewModel: timerViewModel,
                        workout: workout
                    )
                }
            }
        }
    }
}

struct WorkoutRowView: View {
    let workout: WorkoutPlan

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: workout.iconName)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 44, height: 44)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(workout.name)
                    .font(.headline)

                Text(workout.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                HStack(spacing: 12) {
                    Label("\(workout.exercises.count) exercises", systemImage: "list.bullet")
                    Label("\(workout.estimatedDuration) min", systemImage: "clock")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    WorkoutListView(workoutViewModel: WorkoutViewModel(), timerViewModel: TimerViewModel())
        .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
