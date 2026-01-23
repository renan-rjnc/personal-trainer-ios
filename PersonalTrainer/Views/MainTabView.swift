import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var workoutViewModel = WorkoutViewModel()
    @State private var timerViewModel = TimerViewModel()
    @Environment(\.modelContext) private var modelContext

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
        .fullScreenCover(isPresented: $workoutViewModel.isWorkoutActive) {
            if let workout = workoutViewModel.currentWorkout {
                ActiveWorkoutView(
                    workoutViewModel: workoutViewModel,
                    timerViewModel: timerViewModel,
                    workout: workout
                )
            }
        }
        .sheet(isPresented: $workoutViewModel.showFeedbackSheet) {
            if let session = workoutViewModel.completedSession {
                WorkoutFeedbackView(
                    session: session,
                    onSubmit: { feedback in
                        workoutViewModel.submitFeedback(feedback, modelContext: modelContext)
                    },
                    onSkip: {
                        workoutViewModel.completedSession = nil
                        workoutViewModel.showFeedbackSheet = false
                    }
                )
                .presentationDetents([.medium, .large])
            }
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
