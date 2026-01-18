import Foundation
import SwiftData

@Model
final class WorkoutSession {
    var id: UUID
    var date: Date
    var workoutPlanName: String
    var duration: TimeInterval
    @Relationship(deleteRule: .cascade) var exerciseSets: [ExerciseSet]

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        workoutPlanName: String,
        duration: TimeInterval,
        exerciseSets: [ExerciseSet] = []
    ) {
        self.id = id
        self.date = date
        self.workoutPlanName = workoutPlanName
        self.duration = duration
        self.exerciseSets = exerciseSets
    }

    var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        let seconds = Int(duration) % 60

        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    var totalVolume: Double {
        exerciseSets.reduce(0) { $0 + (Double($1.reps) * $1.weight) }
    }

    var totalSets: Int {
        exerciseSets.count
    }
}
