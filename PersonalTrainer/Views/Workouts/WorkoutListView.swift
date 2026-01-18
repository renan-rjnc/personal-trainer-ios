import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    @Query(sort: \CustomWorkoutPlan.createdDate, order: .forward) private var customPlans: [CustomWorkoutPlan]
    @Query(sort: \WorkoutSession.date, order: .reverse) private var sessions: [WorkoutSession]
    @Environment(\.modelContext) private var modelContext

    @State private var showingCreatePlan = false

    let prebuiltWorkouts = SampleWorkouts.allWorkouts

    var body: some View {
        NavigationStack {
            List {
                // Create New Plan Section
                Section {
                    Button(action: {
                        showingCreatePlan = true
                    }) {
                        HStack(spacing: 16) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.green)
                                .frame(width: 44, height: 44)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(10)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Create New Plan")
                                    .font(.headline)
                                    .foregroundStyle(.primary)

                                Text("Build a custom workout routine")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(.plain)
                }

                // Custom Plans Section
                if !customPlans.isEmpty {
                    Section("My Plans") {
                        ForEach(customPlans) { customPlan in
                            NavigationLink(destination: WorkoutDetailView(
                                workout: customPlan.toWorkoutPlan(),
                                workoutViewModel: workoutViewModel,
                                timerViewModel: timerViewModel
                            )) {
                                CustomPlanRowView(plan: customPlan)
                            }
                        }
                        .onDelete(perform: deleteCustomPlans)
                    }
                }

                // Pre-built Plans Section
                Section("Pre-built Plans") {
                    ForEach(prebuiltWorkouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(
                            workout: workout,
                            workoutViewModel: workoutViewModel,
                            timerViewModel: timerViewModel
                        )) {
                            WorkoutRowView(workout: workout)
                        }
                    }
                }
            }
            .navigationTitle("Workouts")
            .sheet(isPresented: $showingCreatePlan) {
                CreatePlanView()
            }
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

    private func deleteCustomPlans(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(customPlans[index])
        }
    }
}

struct CustomPlanRowView: View {
    let plan: CustomWorkoutPlan

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: plan.iconName)
                .font(.title2)
                .foregroundStyle(.purple)
                .frame(width: 44, height: 44)
                .background(Color.purple.opacity(0.1))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(plan.name)
                    .font(.headline)

                Text(plan.planDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                HStack(spacing: 12) {
                    Label("\(plan.exerciseNames.count) exercises", systemImage: "list.bullet")
                    Label("\(plan.estimatedDuration) min", systemImage: "clock")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct WorkoutRowView: View {
    let workout: WorkoutPlan

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: workout.iconName)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 44, height: 44)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(workout.name)
                    .font(.headline)

                Text(workout.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                HStack(spacing: 12) {
                    Label("\(workout.exercises.count) exercises", systemImage: "list.bullet")
                    Label("\(workout.estimatedDuration) min", systemImage: "clock")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    WorkoutListView(workoutViewModel: WorkoutViewModel(), timerViewModel: TimerViewModel())
        .modelContainer(for: [WorkoutSession.self, ExerciseSet.self, CustomWorkoutPlan.self], inMemory: true)
}
