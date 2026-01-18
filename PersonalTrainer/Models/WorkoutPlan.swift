import Foundation

struct WorkoutPlan: Identifiable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let exercises: [Exercise]
    let estimatedDuration: Int
    let iconName: String

    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        exercises: [Exercise],
        estimatedDuration: Int,
        iconName: String = "dumbbell.fill"
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.exercises = exercises
        self.estimatedDuration = estimatedDuration
        self.iconName = iconName
    }
}
