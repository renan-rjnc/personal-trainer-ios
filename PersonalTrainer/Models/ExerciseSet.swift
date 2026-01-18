import Foundation
import SwiftData

@Model
final class ExerciseSet {
    var id: UUID
    var exerciseName: String
    var setNumber: Int
    var reps: Int
    var weight: Double

    init(
        id: UUID = UUID(),
        exerciseName: String,
        setNumber: Int,
        reps: Int,
        weight: Double
    ) {
        self.id = id
        self.exerciseName = exerciseName
        self.setNumber = setNumber
        self.reps = reps
        self.weight = weight
    }
}
