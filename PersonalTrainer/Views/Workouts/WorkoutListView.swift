import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    @Query(sort: \CustomWorkoutPlan.createdDate, order: .forward) private var customPlans: [CustomWorkoutPlan]
    @Query(sort: \WorkoutSession.date, order: .reverse) private var sessions: [WorkoutSession]
    @Environment(\.modelContext) private var modelContext

    @State private var showingCreatePlan = false
    @State private var showPreviousPlans = false

    let prebuiltWorkouts = SampleWorkouts.allWorkouts

    // Filter active and previous plans
    private var activePlans: [CustomWorkoutPlan] {
        customPlans.filter { $0.isActive }
    }

    private var previousPlans: [CustomWorkoutPlan] {
        customPlans.filter { !$0.isActive }
    }

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

                // Active Plans Section (Current Routine)
                if !activePlans.isEmpty {
                    Section("My Current Plan") {
                        ForEach(activePlans) { customPlan in
                            NavigationLink(destination: WorkoutDetailView(
                                workout: customPlan.toWorkoutPlan(),
                                workoutViewModel: workoutViewModel,
                                timerViewModel: timerViewModel
                            )) {
                                CustomPlanRowView(plan: customPlan)
                            }
                        }
                        .onDelete(perform: deleteActivePlans)
                    }
                }

                // Previous Plans Section (Archived)
                if !previousPlans.isEmpty {
                    Section {
                        DisclosureGroup(isExpanded: $showPreviousPlans) {
                            ForEach(previousPlans) { customPlan in
                                NavigationLink(destination: WorkoutDetailView(
                                    workout: customPlan.toWorkoutPlan(),
                                    workoutViewModel: workoutViewModel,
                                    timerViewModel: timerViewModel
                                )) {
                                    CustomPlanRowView(plan: customPlan, isArchived: true)
                                }
                            }
                            .onDelete(perform: deletePreviousPlans)
                        } label: {
                            HStack {
                                Image(systemName: "archivebox.fill")
                                    .foregroundStyle(.secondary)
                                Text("Previous Plans")
                                    .foregroundStyle(.primary)
                                Spacer()
                                Text("\(previousPlans.count)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
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
        }
    }

    private func deleteActivePlans(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(activePlans[index])
        }
    }

    private func deletePreviousPlans(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(previousPlans[index])
        }
    }
}

struct CustomPlanRowView: View {
    let plan: CustomWorkoutPlan
    var isArchived: Bool = false

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: plan.iconName)
                .font(.title2)
                .foregroundStyle(isArchived ? .gray : .purple)
                .frame(width: 44, height: 44)
                .background(isArchived ? Color.gray.opacity(0.1) : Color.purple.opacity(0.1))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(plan.name)
                    .font(.headline)
                    .foregroundStyle(isArchived ? .secondary : .primary)

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
