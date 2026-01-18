import Foundation
import SwiftData

@Model
final class CustomWorkoutPlan {
    var id: UUID
    var name: String
    var planDescription: String
    var daysPerWeek: Int
    var createdDate: Date
    var isActive: Bool
    var exerciseNames: [String]  // Store exercise names to reference from SampleWorkouts
    var iconName: String
    var estimatedDuration: Int

    init(
        id: UUID = UUID(),
        name: String,
        planDescription: String,
        daysPerWeek: Int,
        createdDate: Date = Date(),
        isActive: Bool = true,
        exerciseNames: [String] = [],
        iconName: String = "dumbbell.fill",
        estimatedDuration: Int = 45
    ) {
        self.id = id
        self.name = name
        self.planDescription = planDescription
        self.daysPerWeek = daysPerWeek
        self.createdDate = createdDate
        self.isActive = isActive
        self.exerciseNames = exerciseNames
        self.iconName = iconName
        self.estimatedDuration = estimatedDuration
    }

    var exercises: [Exercise] {
        exerciseNames.compactMap { name in
            WorkoutPlanGenerator.allExercises.first { $0.name == name }
        }
    }

    func toWorkoutPlan() -> WorkoutPlan {
        WorkoutPlan(
            id: id,
            name: name,
            description: planDescription,
            exercises: exercises,
            estimatedDuration: estimatedDuration,
            iconName: iconName
        )
    }
}
