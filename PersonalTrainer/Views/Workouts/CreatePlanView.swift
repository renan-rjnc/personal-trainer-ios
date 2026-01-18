import SwiftUI
import SwiftData

struct CreatePlanView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var currentStep: Int = 1
    @State private var daysPerWeek: Int = 3
    @State private var generatedPlans: [GeneratedWorkoutDay] = []
    @State private var selectedPlans: Set<UUID> = []
    @State private var planName: String = ""
    @State private var isGenerating: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                // Progress indicator
                ProgressView(value: Double(currentStep), total: 3)
                    .padding(.horizontal)

                switch currentStep {
                case 1:
                    frequencySelectionView
                case 2:
                    planPreviewView
                case 3:
                    confirmationView
                default:
                    EmptyView()
                }
            }
            .navigationTitle("Create Workout Plan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    // MARK: - Step 1: Frequency Selection
    private var frequencySelectionView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "calendar")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text("How many days per week\ndo you want to work out?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            // Days selector
            VStack(spacing: 16) {
                HStack {
                    ForEach(2...6, id: \.self) { days in
                        Button(action: {
                            daysPerWeek = days
                        }) {
                            Text("\(days)")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(width: 56, height: 56)
                                .background(daysPerWeek == days ? Color.blue : Color(.systemGray5))
                                .foregroundStyle(daysPerWeek == days ? .white : .primary)
                                .cornerRadius(12)
                        }
                    }
                }

                Text("\(daysPerWeek) days per week")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text(recommendationText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Spacer()

            Button(action: {
                generatePlans()
            }) {
                HStack {
                    Text("Generate Plan")
                    Image(systemName: "arrow.right")
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
            .disabled(isGenerating)
        }
        .padding()
    }

    private var recommendationText: String {
        switch daysPerWeek {
        case 2:
            return "Upper/Lower split - Great for beginners or busy schedules"
        case 3:
            return "Push/Pull/Legs - Popular and effective for most people"
        case 4:
            return "Upper/Lower x2 - Good balance of volume and recovery"
        case 5:
            return "Body part split - For intermediate to advanced lifters"
        case 6:
            return "Push/Pull/Legs x2 - High volume for serious training"
        default:
            return ""
        }
    }

    // MARK: - Step 2: Plan Preview
    private var planPreviewView: some View {
        VStack(spacing: 16) {
            Text("Your Workout Split")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            Text("Here's your personalized \(daysPerWeek)-day split")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array(generatedPlans.enumerated()), id: \.element.id) { index, plan in
                        GeneratedPlanCard(
                            dayNumber: index + 1,
                            plan: plan,
                            isSelected: selectedPlans.contains(plan.id),
                            onTap: {
                                if selectedPlans.contains(plan.id) {
                                    selectedPlans.remove(plan.id)
                                } else {
                                    selectedPlans.insert(plan.id)
                                }
                            }
                        )
                    }
                }
                .padding()
            }

            HStack {
                Button(action: {
                    currentStep = 1
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                }
                .buttonStyle(.bordered)

                Spacer()

                Button(action: {
                    // Regenerate with new random selection
                    generatePlans()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Shuffle")
                    }
                }
                .buttonStyle(.bordered)

                Button(action: {
                    selectedPlans = Set(generatedPlans.map { $0.id })
                    currentStep = 3
                }) {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right")
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }

    // MARK: - Step 3: Confirmation
    private var confirmationView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)

            Text("Almost Done!")
                .font(.title)
                .fontWeight(.bold)

            Text("Give your plan a name")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            TextField("Plan Name", text: $planName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)

            VStack(alignment: .leading, spacing: 8) {
                Text("Plan Summary")
                    .font(.headline)

                Text("\(daysPerWeek) days per week")
                Text("\(generatedPlans.flatMap { $0.exercises }.count) total exercises")
                Text("Estimated \(generatedPlans.reduce(0) { $0 + $1.estimatedDuration }) minutes per week")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)

            Spacer()

            HStack {
                Button(action: {
                    currentStep = 2
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                }
                .buttonStyle(.bordered)

                Spacer()

                Button(action: {
                    savePlans()
                }) {
                    HStack {
                        Text("Create Plan")
                        Image(systemName: "checkmark")
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(planName.isEmpty)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding()
        .onAppear {
            if planName.isEmpty {
                planName = "My \(daysPerWeek)-Day Split"
            }
        }
    }

    // MARK: - Functions
    private func generatePlans() {
        isGenerating = true
        generatedPlans = WorkoutPlanGenerator.generatePlans(daysPerWeek: daysPerWeek)
        selectedPlans = Set(generatedPlans.map { $0.id })
        isGenerating = false
        currentStep = 2
    }

    private func savePlans() {
        for (index, plan) in generatedPlans.enumerated() {
            let customPlan = CustomWorkoutPlan(
                name: "\(planName) - Day \(index + 1): \(plan.name)",
                planDescription: plan.description,
                daysPerWeek: daysPerWeek,
                isActive: true,
                exerciseNames: plan.exerciseNames,
                iconName: plan.iconName,
                estimatedDuration: plan.estimatedDuration
            )
            modelContext.insert(customPlan)
        }

        try? modelContext.save()
        dismiss()
    }
}

struct GeneratedPlanCard: View {
    let dayNumber: Int
    let plan: GeneratedWorkoutDay
    let isSelected: Bool
    let onTap: () -> Void

    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 44, height: 44)

                        Text("Day \(dayNumber)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(plan.name)
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Text(plan.description)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text("\(plan.exercises.count) exercises")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text("~\(plan.estimatedDuration) min")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)

            if isExpanded {
                Divider()

                ForEach(plan.exercises) { exercise in
                    HStack {
                        Image(systemName: exercise.imageName)
                            .foregroundStyle(.blue)
                            .frame(width: 24)

                        Text(exercise.name)
                            .font(.subheadline)

                        Spacer()

                        Text("\(exercise.defaultSets)×\(exercise.defaultReps)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.leading, 8)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    CreatePlanView()
        .modelContainer(for: [CustomWorkoutPlan.self, WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
