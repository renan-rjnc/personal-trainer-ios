import SwiftUI
import SwiftData

struct HomeView: View {
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    @Query(sort: \WorkoutSession.date, order: .reverse) private var recentSessions: [WorkoutSession]
    @Environment(\.modelContext) private var modelContext

    private var thisWeekSessions: [WorkoutSession] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
        return recentSessions.filter { $0.date >= startOfWeek }
    }

    private var totalWeeklyDuration: TimeInterval {
        thisWeekSessions.reduce(0) { $0 + $1.duration }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Section
                    welcomeSection

                    // Weekly Stats
                    weeklyStatsSection

                    // Quick Start Section
                    quickStartSection

                    // Recent Workout
                    if let lastSession = recentSessions.first {
                        recentWorkoutSection(session: lastSession)
                    }
                }
                .padding()
            }
            .navigationTitle("Personal Trainer")
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

    private var welcomeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(greeting)
                .font(.title2)
                .foregroundStyle(.secondary)
            Text("Ready to train?")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }

    private var weeklyStatsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("This Week")
                .font(.headline)

            HStack(spacing: 16) {
                StatCard(
                    title: "Workouts",
                    value: "\(thisWeekSessions.count)",
                    icon: "flame.fill",
                    color: .orange
                )

                StatCard(
                    title: "Duration",
                    value: formatDuration(totalWeeklyDuration),
                    icon: "clock.fill",
                    color: .blue
                )

                StatCard(
                    title: "Sets",
                    value: "\(thisWeekSessions.reduce(0) { $0 + $1.totalSets })",
                    icon: "checkmark.circle.fill",
                    color: .green
                )
            }
        }
    }

    private var quickStartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Start")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(SampleWorkouts.allWorkouts.prefix(4)) { workout in
                    QuickStartCard(workout: workout) {
                        workoutViewModel.startWorkout(plan: workout, pastSessions: recentSessions)
                    }
                }
            }
        }
    }

    private func recentWorkoutSection(session: WorkoutSession) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Workout")
                .font(.headline)

            NavigationLink(destination: HistoryDetailView(session: session)) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(session.workoutPlanName)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text(session.formattedDate)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        Text(session.formattedDuration)
                            .font(.title3)
                            .fontWeight(.medium)
                        Text("\(session.totalSets) sets")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
            .buttonStyle(.plain)
        }
    }

    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        }
        return "\(minutes)m"
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct QuickStartCard: View {
    let workout: WorkoutPlan
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: workout.iconName)
                    .font(.title)
                    .foregroundStyle(.blue)

                Text(workout.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)

                Text("\(workout.estimatedDuration) min")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView(workoutViewModel: WorkoutViewModel(), timerViewModel: TimerViewModel())
        .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
