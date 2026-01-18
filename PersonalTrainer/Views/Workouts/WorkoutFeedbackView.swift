import SwiftUI
import SwiftData

struct WorkoutFeedbackView: View {
    let session: WorkoutSession
    let onSubmit: (DifficultyFeedback) -> Void
    let onSkip: () -> Void

    @State private var selectedFeedback: DifficultyFeedback?
    @State private var showingAdjustmentSuggestion: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                // Celebration
                Image(systemName: "trophy.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.yellow)

                Text("Workout Complete!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Stats
                HStack(spacing: 32) {
                    VStack {
                        Text(session.formattedDuration)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Duration")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    VStack {
                        Text("\(session.totalSets)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Sets")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    VStack {
                        Text(formatVolume(session.totalVolume))
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Volume")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                Spacer()

                // Feedback question
                Text("How was this workout?")
                    .font(.headline)

                HStack(spacing: 16) {
                    ForEach(DifficultyFeedback.allCases, id: \.self) { feedback in
                        FeedbackButton(
                            feedback: feedback,
                            isSelected: selectedFeedback == feedback,
                            action: {
                                selectedFeedback = feedback
                            }
                        )
                    }
                }

                if let feedback = selectedFeedback {
                    Text(feedbackMessage(for: feedback))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Spacer()

                VStack(spacing: 12) {
                    Button(action: {
                        if let feedback = selectedFeedback {
                            onSubmit(feedback)
                        }
                    }) {
                        Text("Save Feedback")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(selectedFeedback == nil)

                    Button(action: onSkip) {
                        Text("Skip")
                            .font(.subheadline)
                    }
                    .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding()
        }
    }

    private func formatVolume(_ volume: Double) -> String {
        if volume >= 1000 {
            return String(format: "%.1fk lbs", volume / 1000)
        }
        return "\(Int(volume)) lbs"
    }

    private func feedbackMessage(for feedback: DifficultyFeedback) -> String {
        switch feedback {
        case .tooEasy:
            return "Consider increasing weight or adding more sets next time."
        case .justRight:
            return "Perfect! Keep up the great work."
        case .tooHard:
            return "Consider reducing weight or taking longer rest periods."
        }
    }
}

struct FeedbackButton: View {
    let feedback: DifficultyFeedback
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(feedback.emoji)
                    .font(.system(size: 40))

                Text(feedback.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .frame(width: 100, height: 100)
            .background(isSelected ? feedbackColor.opacity(0.2) : Color(.systemGray6))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? feedbackColor : Color.clear, lineWidth: 3)
            )
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }

    private var feedbackColor: Color {
        switch feedback {
        case .tooEasy: return .green
        case .justRight: return .blue
        case .tooHard: return .orange
        }
    }
}

// MARK: - Plan Adjustment Suggestion View
struct PlanAdjustmentView: View {
    let workoutName: String
    let recentFeedback: [DifficultyFeedback]
    let onAccept: () -> Void
    let onDecline: () -> Void

    var suggestion: AdjustmentSuggestion? {
        let tooEasyCount = recentFeedback.filter { $0 == .tooEasy }.count
        let tooHardCount = recentFeedback.filter { $0 == .tooHard }.count

        if tooEasyCount >= 2 {
            return .increase
        } else if tooHardCount >= 2 {
            return .decrease
        }
        return nil
    }

    enum AdjustmentSuggestion {
        case increase
        case decrease

        var title: String {
            switch self {
            case .increase: return "Ready for More?"
            case .decrease: return "Need to Adjust?"
            }
        }

        var message: String {
            switch self {
            case .increase:
                return "You've marked your recent workouts as too easy. Would you like to increase the difficulty?"
            case .decrease:
                return "You've marked your recent workouts as too hard. Would you like to reduce the difficulty?"
            }
        }

        var icon: String {
            switch self {
            case .increase: return "arrow.up.circle.fill"
            case .decrease: return "arrow.down.circle.fill"
            }
        }

        var color: Color {
            switch self {
            case .increase: return .green
            case .decrease: return .orange
            }
        }
    }

    var body: some View {
        if let suggestion = suggestion {
            VStack(spacing: 16) {
                Image(systemName: suggestion.icon)
                    .font(.system(size: 40))
                    .foregroundStyle(suggestion.color)

                Text(suggestion.title)
                    .font(.headline)

                Text(suggestion.message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                HStack(spacing: 12) {
                    Button("Not Now", action: onDecline)
                        .buttonStyle(.bordered)

                    Button("Adjust Plan", action: onAccept)
                        .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .padding()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: WorkoutSession.self, ExerciseSet.self, configurations: config)

    let session = WorkoutSession(
        date: Date(),
        workoutPlanName: "Push Day",
        duration: 2700,
        exerciseSets: [
            ExerciseSet(exerciseName: "Bench Press", setNumber: 1, reps: 10, weight: 135),
            ExerciseSet(exerciseName: "Bench Press", setNumber: 2, reps: 8, weight: 155),
        ]
    )

    return WorkoutFeedbackView(
        session: session,
        onSubmit: { _ in },
        onSkip: { }
    )
    .modelContainer(container)
}
