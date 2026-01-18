import Foundation

struct Exercise: Identifiable, Hashable {
    let id: UUID
    let name: String
    let muscleGroups: [String]
    let instructions: String
    let imageName: String
    let videoURL: String?
    let defaultSets: Int
    let defaultReps: Int

    init(
        id: UUID = UUID(),
        name: String,
        muscleGroups: [String],
        instructions: String,
        imageName: String = "figure.strengthtraining.traditional",
        videoURL: String? = nil,
        defaultSets: Int = 3,
        defaultReps: Int = 10
    ) {
        self.id = id
        self.name = name
        self.muscleGroups = muscleGroups
        self.instructions = instructions
        self.imageName = imageName
        self.videoURL = videoURL
        self.defaultSets = defaultSets
        self.defaultReps = defaultReps
    }
}
