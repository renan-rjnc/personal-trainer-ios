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

    // Weight memory - stores last used weights per exercise
    var exerciseWeightHistory: [String: Double] = [:]

    // Completed session for feedback
    var completedSession: WorkoutSession?
    var showFeedbackSheet: Bool = false

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

    func startWorkout(plan: WorkoutPlan, pastSessions: [WorkoutSession] = []) {
        currentWorkout = plan
        currentExerciseIndex = 0
        isWorkoutActive = true
        workoutStartTime = Date()
        completedSets = []

        // Load weight history from past sessions
        loadWeightHistory(from: pastSessions)

        resetCurrentSet()
    }

    func loadWeightHistory(from sessions: [WorkoutSession]) {
        exerciseWeightHistory = [:]

        // Sort sessions by date, most recent first
        let sortedSessions = sessions.sorted { $0.date > $1.date }

        // Get the most recent weight for each exercise
        for session in sortedSessions {
            for set in session.exerciseSets {
                if exerciseWeightHistory[set.exerciseName] == nil && set.weight > 0 {
                    exerciseWeightHistory[set.exerciseName] = set.weight
                }
            }
        }
    }

    func getLastWeight(for exerciseName: String) -> Double? {
        return exerciseWeightHistory[exerciseName]
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

    func finishWorkout(modelContext: ModelContext, showFeedback: Bool = true) -> WorkoutSession? {
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

        // Store for feedback
        if showFeedback {
            completedSession = session
            showFeedbackSheet = true
        }

        // Reset workout state but keep session for feedback
        currentWorkout = nil
        currentExerciseIndex = 0
        isWorkoutActive = false
        workoutStartTime = nil
        completedSets = []

        return session
    }

    func submitFeedback(_ feedback: DifficultyFeedback, modelContext: ModelContext) {
        if let session = completedSession {
            session.feedback = feedback
            try? modelContext.save()
        }
        completedSession = nil
        showFeedbackSheet = false
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
            // Use last recorded weight for this exercise, or 0 if none
            currentWeight = exerciseWeightHistory[exercise.name] ?? 0
        }
    }

    // Public method for resetting when swiping between exercises
    func resetCurrentSetForExercise() {
        resetCurrentSet()
    }

    // MARK: - Exercise Replacement

    /// Get alternative exercises that share at least one muscle group with the given exercise
    func getAlternativeExercises(for exercise: Exercise) -> [Exercise] {
        let allExercises = WorkoutPlanGenerator.allExercises
        let currentExerciseNames = Set(currentWorkout?.exercises.map { $0.name } ?? [])

        // Find exercises that share at least one muscle group
        let alternatives = allExercises.filter { candidate in
            // Don't include the current exercise or exercises already in the workout
            guard candidate.name != exercise.name,
                  !currentExerciseNames.contains(candidate.name) else {
                return false
            }

            // Check if they share any muscle groups
            let sharedMuscles = Set(candidate.muscleGroups).intersection(Set(exercise.muscleGroups))
            return !sharedMuscles.isEmpty
        }

        // Sort by number of matching muscle groups (most similar first)
        return alternatives.sorted { a, b in
            let aMatches = Set(a.muscleGroups).intersection(Set(exercise.muscleGroups)).count
            let bMatches = Set(b.muscleGroups).intersection(Set(exercise.muscleGroups)).count
            return aMatches > bMatches
        }
    }

    /// Replace an exercise in the current workout
    func replaceExercise(at index: Int, with newExercise: Exercise) {
        guard var workout = currentWorkout,
              index >= 0 && index < workout.exercises.count else {
            return
        }

        var exercises = workout.exercises
        exercises[index] = newExercise

        // Create updated workout plan
        currentWorkout = WorkoutPlan(
            id: workout.id,
            name: workout.name,
            description: workout.description,
            exercises: exercises,
            estimatedDuration: workout.estimatedDuration,
            iconName: workout.iconName
        )

        // Reset current set for the new exercise
        resetCurrentSet()
    }
}
