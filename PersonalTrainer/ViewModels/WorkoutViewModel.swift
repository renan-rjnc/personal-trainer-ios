import Foundation
import SwiftUI
import SwiftData

@Observable
final class WorkoutViewModel {
    var currentWorkout: WorkoutPlan?
    var currentExerciseIndex: Int = 0
    var isWorkoutActive: Bool = false
    var workoutStartTime: Date?

    // Set tracking during active workout
    var completedSets: [ExerciseSet] = []
    var currentSetNumber: Int = 1
    var currentReps: Int = 10
    var currentWeight: Double = 0

    var currentExercise: Exercise? {
        guard let workout = currentWorkout,
              currentExerciseIndex < workout.exercises.count else {
            return nil
        }
        return workout.exercises[currentExerciseIndex]
    }

    var exerciseProgress: String {
        guard let workout = currentWorkout else { return "" }
        return "\(currentExerciseIndex + 1) of \(workout.exercises.count)"
    }

    var workoutDuration: TimeInterval {
        guard let startTime = workoutStartTime else { return 0 }
        return Date().timeIntervalSince(startTime)
    }

    var setsForCurrentExercise: [ExerciseSet] {
        guard let exercise = currentExercise else { return [] }
        return completedSets.filter { $0.exerciseName == exercise.name }
    }

    func startWorkout(plan: WorkoutPlan) {
        currentWorkout = plan
        currentExerciseIndex = 0
        isWorkoutActive = true
        workoutStartTime = Date()
        completedSets = []
        resetCurrentSet()
    }

    func nextExercise() {
        guard let workout = currentWorkout,
              currentExerciseIndex < workout.exercises.count - 1 else {
            return
        }
        currentExerciseIndex += 1
        resetCurrentSet()
    }

    func previousExercise() {
        guard currentExerciseIndex > 0 else { return }
        currentExerciseIndex -= 1
        resetCurrentSet()
    }

    func logSet() {
        guard let exercise = currentExercise else { return }

        let newSet = ExerciseSet(
            exerciseName: exercise.name,
            setNumber: setsForCurrentExercise.count + 1,
            reps: currentReps,
            weight: currentWeight
        )

        completedSets.append(newSet)
        currentSetNumber = setsForCurrentExercise.count + 1
    }

    func deleteSet(_ set: ExerciseSet) {
        completedSets.removeAll { $0.id == set.id }
    }

    func finishWorkout(modelContext: ModelContext) -> WorkoutSession? {
        guard let workout = currentWorkout, let startTime = workoutStartTime else {
            return nil
        }

        let duration = Date().timeIntervalSince(startTime)

        let session = WorkoutSession(
            date: startTime,
            workoutPlanName: workout.name,
            duration: duration,
            exerciseSets: completedSets
        )

        modelContext.insert(session)

        // Reset state
        endWorkout()

        return session
    }

    func endWorkout() {
        currentWorkout = nil
        currentExerciseIndex = 0
        isWorkoutActive = false
        workoutStartTime = nil
        completedSets = []
        resetCurrentSet()
    }

    private func resetCurrentSet() {
        currentSetNumber = setsForCurrentExercise.count + 1
        if let exercise = currentExercise {
            currentReps = exercise.defaultReps
        }
    }
}
