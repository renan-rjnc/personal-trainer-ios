import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var workoutViewModel = WorkoutViewModel()
    @State private var timerViewModel = TimerViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(workoutViewModel: workoutViewModel, timerViewModel: timerViewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            WorkoutListView(workoutViewModel: workoutViewModel, timerViewModel: timerViewModel)
                .tabItem {
                    Label("Workouts", systemImage: "dumbbell.fill")
                }
                .tag(1)

            HistoryListView()
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
                .tag(2)
        }
        .tint(.blue)
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
