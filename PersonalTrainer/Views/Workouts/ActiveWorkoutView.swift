import SwiftUI

enum ExerciseStatus {
    case pending
    case done
    case skipped
}

struct ActiveWorkoutView: View {
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    let workout: WorkoutPlan
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingExitAlert = false
    @State private var showingFinishAlert = false
    @State private var exerciseStatuses: [UUID: ExerciseStatus] = [:]
    @State private var selectedExerciseIndex: Int = 0

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress indicators
                exerciseProgressIndicator
                    .padding(.horizontal)
                    .padding(.top, 8)

                // Timer Section (compact)
                compactTimerSection
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))

                // Swipeable Exercise Pages
                TabView(selection: $selectedExerciseIndex) {
                    ForEach(Array(workout.exercises.enumerated()), id: \.element.id) { index, exercise in
                        ExercisePageView(
                            exercise: exercise,
                            exerciseNumber: index + 1,
                            totalExercises: workout.exercises.count,
                            status: exerciseStatuses[exercise.id] ?? .pending,
                            workoutViewModel: workoutViewModel,
                            timerViewModel: timerViewModel,
                            onMarkDone: {
                                markExerciseDone(exercise)
                            },
                            onSkip: {
                                skipExercise(exercise)
                            }
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: selectedExerciseIndex) { _, newIndex in
                    workoutViewModel.currentExerciseIndex = newIndex
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
            .onAppear {
                // Initialize all exercises as pending
                for exercise in workout.exercises {
                    if exerciseStatuses[exercise.id] == nil {
                        exerciseStatuses[exercise.id] = .pending
                    }
                }
            }
        }
    }

    // MARK: - Progress Indicator
    private var exerciseProgressIndicator: some View {
        HStack(spacing: 4) {
            ForEach(Array(workout.exercises.enumerated()), id: \.element.id) { index, exercise in
                Button(action: {
                    withAnimation {
                        selectedExerciseIndex = index
                    }
                }) {
                    Circle()
                        .fill(statusColor(for: exercise))
                        .frame(width: index == selectedExerciseIndex ? 12 : 8,
                               height: index == selectedExerciseIndex ? 12 : 8)
                        .overlay(
                            Circle()
                                .stroke(index == selectedExerciseIndex ? Color.blue : Color.clear, lineWidth: 2)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 8)
    }

    private func statusColor(for exercise: Exercise) -> Color {
        switch exerciseStatuses[exercise.id] ?? .pending {
        case .done: return .green
        case .skipped: return .orange
        case .pending: return Color(.systemGray4)
        }
    }

    // MARK: - Compact Timer
    private var compactTimerSection: some View {
        HStack(spacing: 16) {
            // Timer Display
            Text(timerViewModel.formattedTime)
                .font(.system(size: 24, weight: .medium, design: .monospaced))
                .foregroundStyle(timerViewModel.isCountdownComplete ? .red : .primary)

            Spacer()

            // Mode Toggle
            Picker("", selection: Binding(
                get: { timerViewModel.mode },
                set: { newMode in
                    if newMode == .stopwatch {
                        timerViewModel.switchToStopwatch()
                    } else {
                        timerViewModel.setCountdown(seconds: 60)
                    }
                }
            )) {
                Image(systemName: "stopwatch").tag(TimerViewModel.TimerMode.stopwatch)
                Image(systemName: "timer").tag(TimerViewModel.TimerMode.countdown)
            }
            .pickerStyle(.segmented)
            .frame(width: 100)

            // Timer Controls
            HStack(spacing: 8) {
                Button(action: {
                    timerViewModel.reset()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.body)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Button(action: {
                    if timerViewModel.isRunning {
                        timerViewModel.pause()
                    } else {
                        timerViewModel.start()
                    }
                }) {
                    Image(systemName: timerViewModel.isRunning ? "pause.fill" : "play.fill")
                        .font(.body)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
            }
        }
    }

    // MARK: - Actions
    private func markExerciseDone(_ exercise: Exercise) {
        exerciseStatuses[exercise.id] = .done
        moveToNextExercise()
    }

    private func skipExercise(_ exercise: Exercise) {
        exerciseStatuses[exercise.id] = .skipped
        moveToNextExercise()
    }

    private func moveToNextExercise() {
        if selectedExerciseIndex < workout.exercises.count - 1 {
            withAnimation {
                selectedExerciseIndex += 1
            }
        }
    }
}

// MARK: - Exercise Page View
struct ExercisePageView: View {
    let exercise: Exercise
    let exerciseNumber: Int
    let totalExercises: Int
    let status: ExerciseStatus
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    let onMarkDone: () -> Void
    let onSkip: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Exercise Header with Status
                exerciseHeader

                // Set Input Section
                setInputSection

                // Completed Sets
                completedSetsSection

                // Done/Skip Buttons
                actionButtons

                // Swipe hint
                swipeHint
            }
            .padding()
        }
    }

    private var exerciseHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Exercise \(exerciseNumber) of \(totalExercises)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                if status != .pending {
                    Label(
                        status == .done ? "Done" : "Skipped",
                        systemImage: status == .done ? "checkmark.circle.fill" : "forward.fill"
                    )
                    .font(.caption)
                    .foregroundStyle(status == .done ? .green : .orange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(status == .done ? Color.green.opacity(0.1) : Color.orange.opacity(0.1))
                    .cornerRadius(8)
                }
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

                        if let lastWeight = workoutViewModel.getLastWeight(for: exercise.name) {
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
            let setsForExercise = workoutViewModel.completedSets.filter { $0.exerciseName == exercise.name }

            if !setsForExercise.isEmpty {
                Text("Completed Sets")
                    .font(.headline)

                ForEach(setsForExercise) { set in
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

    private var actionButtons: some View {
        HStack(spacing: 16) {
            Button(action: onSkip) {
                Label("Skip", systemImage: "forward.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.orange)
            .controlSize(.large)

            Button(action: onMarkDone) {
                Label("Done", systemImage: "checkmark")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .controlSize(.large)
        }
    }

    private var swipeHint: some View {
        HStack {
            Image(systemName: "hand.draw")
                .foregroundStyle(.secondary)
            Text("Swipe left or right to navigate exercises")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 8)
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
