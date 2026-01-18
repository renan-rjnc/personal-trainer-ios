import SwiftUI
import SwiftData

@main
struct PersonalTrainerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WorkoutSession.self,
            ExerciseSet.self,
            CustomWorkoutPlan.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(sharedModelContainer)
    }
}
