import SwiftUI

struct ActiveWorkoutView: View {
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    let workout: WorkoutPlan
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingExitAlert = false
    @State private var showingFinishAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Timer Section
                timerSection
                    .padding()
                    .background(Color(.systemGray6))

                // Exercise Content
                ScrollView {
                    VStack(spacing: 20) {
                        // Current Exercise
                        if let exercise = workoutViewModel.currentExercise {
                            currentExerciseSection(exercise: exercise)
                        }

                        // Set Input
                        setInputSection

                        // Completed Sets
                        completedSetsSection

                        // Navigation Buttons
                        exerciseNavigationSection
                    }
                    .padding()
                }
            }
            .navigationTitle(workout.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Exit") {
                        showingExitAlert = true
                    }
                    .foregroundStyle(.red)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Finish") {
                        showingFinishAlert = true
                    }
                }
            }
            .alert("Exit Workout?", isPresented: $showingExitAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Exit", role: .destructive) {
                    timerViewModel.reset()
                    workoutViewModel.endWorkout()
                    dismiss()
                }
            } message: {
                Text("Your progress will not be saved.")
            }
            .alert("Finish Workout?", isPresented: $showingFinishAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Finish") {
                    timerViewModel.reset()
                    _ = workoutViewModel.finishWorkout(modelContext: modelContext)
                    dismiss()
                }
            } message: {
                Text("This will save your workout to history.")
            }
        }
    }

    private var timerSection: some View {
        VStack(spacing: 12) {
            // Timer Display
            Text(timerViewModel.formattedTime)
                .font(.system(size: 48, weight: .medium, design: .monospaced))
                .foregroundStyle(timerViewModel.isCountdownComplete ? .red : .primary)

            // Timer Mode Toggle
            Picker("Timer Mode", selection: Binding(
                get: { timerViewModel.mode },
                set: { newMode in
                    if newMode == .stopwatch {
                        timerViewModel.switchToStopwatch()
                    } else {
                        timerViewModel.setCountdown(seconds: 60)
                    }
                }
            )) {
                Text("Stopwatch").tag(TimerViewModel.TimerMode.stopwatch)
                Text("Countdown").tag(TimerViewModel.TimerMode.countdown)
            }
            .pickerStyle(.segmented)
            .frame(width: 200)

            // Countdown Presets
            if timerViewModel.mode == .countdown {
                HStack(spacing: 8) {
                    ForEach(timerViewModel.countdownPresets, id: \.self) { seconds in
                        Button(formatSeconds(seconds)) {
                            timerViewModel.setCountdown(seconds: seconds)
                        }
                        .buttonStyle(.bordered)
                        .tint(timerViewModel.countdownDuration == seconds ? .blue : .gray)
                    }
                }
            }

            // Timer Controls
            HStack(spacing: 20) {
                Button(action: {
                    timerViewModel.reset()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.bordered)

                Button(action: {
                    if timerViewModel.isRunning {
                        timerViewModel.pause()
                    } else {
                        timerViewModel.start()
                    }
                }) {
                    Image(systemName: timerViewModel.isRunning ? "pause.fill" : "play.fill")
                        .font(.title2)
                        .frame(width: 60, height: 44)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    private func currentExerciseSection(exercise: Exercise) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Exercise \(workoutViewModel.exerciseProgress)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }

            HStack {
                Image(systemName: exercise.imageName)
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                    .frame(width: 60, height: 60)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 4) {
                    Text(exercise.name)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(exercise.muscleGroups.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("Target: \(exercise.defaultSets) sets × \(exercise.defaultReps) reps")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }

                Spacer()
            }

            Text(exercise.instructions)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }

    private var setInputSection: some View {
        VStack(spacing: 16) {
            Text("Log Set")
                .font(.headline)

            HStack(spacing: 20) {
                VStack {
                    Text("Reps")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack {
                        Button(action: {
                            if workoutViewModel.currentReps > 1 {
                                workoutViewModel.currentReps -= 1
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                        }

                        Text("\(workoutViewModel.currentReps)")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 50)

                        Button(action: {
                            workoutViewModel.currentReps += 1
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                }

                VStack {
                    HStack(spacing: 4) {
                        Text("Weight (lbs)")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        if let exercise = workoutViewModel.currentExercise,
                           let lastWeight = workoutViewModel.getLastWeight(for: exercise.name) {
                            Text("• Last: \(Int(lastWeight))")
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }
                    }

                    HStack {
                        Button(action: {
                            if workoutViewModel.currentWeight >= 5 {
                                workoutViewModel.currentWeight -= 5
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                        }

                        Text(String(format: "%.0f", workoutViewModel.currentWeight))
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 60)

                        Button(action: {
                            workoutViewModel.currentWeight += 5
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                }
            }

            Button(action: {
                workoutViewModel.logSet()
                // Auto-start rest timer
                if timerViewModel.mode == .countdown {
                    timerViewModel.reset()
                    timerViewModel.start()
                }
            }) {
                Label("Add Set", systemImage: "plus")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    private var completedSetsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !workoutViewModel.setsForCurrentExercise.isEmpty {
                Text("Completed Sets")
                    .font(.headline)

                ForEach(workoutViewModel.setsForCurrentExercise) { set in
                    HStack {
                        Text("Set \(set.setNumber)")
                            .fontWeight(.medium)

                        Spacer()

                        Text("\(set.reps) reps")
                        Text("×")
                            .foregroundStyle(.secondary)
                        Text("\(Int(set.weight)) lbs")

                        Button(action: {
                            workoutViewModel.deleteSet(set)
                        }) {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
        }
    }

    private var exerciseNavigationSection: some View {
        HStack {
            Button(action: {
                workoutViewModel.previousExercise()
            }) {
                Label("Previous", systemImage: "chevron.left")
            }
            .disabled(workoutViewModel.currentExerciseIndex == 0)

            Spacer()

            Button(action: {
                workoutViewModel.nextExercise()
            }) {
                Label("Next", systemImage: "chevron.right")
            }
            .disabled(workoutViewModel.currentExerciseIndex >= workout.exercises.count - 1)
        }
        .buttonStyle(.bordered)
    }

    private func formatSeconds(_ seconds: TimeInterval) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        if mins > 0 && secs == 0 {
            return "\(mins)m"
        } else if mins > 0 {
            return "\(mins):\(String(format: "%02d", secs))"
        }
        return "\(secs)s"
    }
}

#Preview {
    ActiveWorkoutView(
        workoutViewModel: WorkoutViewModel(),
        timerViewModel: TimerViewModel(),
        workout: SampleWorkouts.pushDay
    )
    .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
