import SwiftUI
import SwiftData

struct CreatePlanView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var existingProfiles: [UserProfile]
    @Query private var existingCustomPlans: [CustomWorkoutPlan]

    // Wizard steps
    @State private var currentStep: Int = 0
    @State private var isGenerating: Bool = false

    // Step 0: Profile info
    @State private var dateOfBirth: Date = Calendar.current.date(byAdding: .year, value: -25, to: Date()) ?? Date()
    @State private var gender: Gender = .preferNotToSay
    @State private var heightFeet: Int = 5
    @State private var heightInches: Int = 8
    @State private var weightPounds: Double = 150

    // Step 1: Fitness goals
    @State private var selectedGoal: FitnessGoal = .generalFitness
    @State private var experienceLevel: ExperienceLevel = .beginner

    // Step 2: Frequency
    @State private var daysPerWeek: Int = 3

    // Step 3: Duration
    @State private var workoutDuration: WorkoutDuration = .standard

    // Advanced Options (defaults: full body, 2x per week)
    @State private var showAdvancedOptions: Bool = false
    @State private var workoutSplit: WorkoutSplit = .fullBody
    @State private var muscleFrequency: MuscleFrequency = .twicePerWeek

    // Step 4: Generated plans
    @State private var generatedPlans: [GeneratedWorkoutDay] = []
    @State private var selectedPlans: Set<UUID> = []

    // Step 5: Confirmation
    @State private var planName: String = ""

    private var totalSteps: Int { 6 }

    private var heightInInches: Double {
        Double(heightFeet * 12 + heightInches)
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Progress indicator
                ProgressView(value: Double(currentStep), total: Double(totalSteps - 1))
                    .padding(.horizontal)

                switch currentStep {
                case 0:
                    profileInfoView
                case 1:
                    fitnessGoalView
                case 2:
                    frequencySelectionView
                case 3:
                    durationSelectionView
                case 4:
                    planPreviewView
                case 5:
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
            .onAppear {
                loadExistingProfile()
            }
        }
    }

    private func loadExistingProfile() {
        if let profile = existingProfiles.first {
            dateOfBirth = profile.dateOfBirth
            gender = profile.genderEnum
            let totalInches = profile.heightInches
            heightFeet = Int(totalInches / 12)
            heightInches = Int(totalInches.truncatingRemainder(dividingBy: 12))
            weightPounds = profile.weightPounds
            selectedGoal = profile.goalEnum
            experienceLevel = profile.experienceEnum
            workoutDuration = profile.workoutDurationEnum
            workoutSplit = profile.workoutSplitEnum
            muscleFrequency = profile.muscleFrequencyEnum
        }
    }

    // MARK: - Step 0: Profile Info
    private var profileInfoView: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)

                Text("Tell Us About Yourself")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)

                Text("This helps us create a personalized workout plan")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 20) {
                    // Date of Birth
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date of Birth")
                            .font(.headline)
                        DatePicker("", selection: $dateOfBirth, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                    }

                    // Gender
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Gender")
                            .font(.headline)
                        Picker("Gender", selection: $gender) {
                            ForEach(Gender.allCases) { g in
                                Text(g.rawValue).tag(g)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    // Height
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Height")
                            .font(.headline)
                        HStack(spacing: 16) {
                            Picker("Feet", selection: $heightFeet) {
                                ForEach(4...7, id: \.self) { ft in
                                    Text("\(ft) ft").tag(ft)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 100, height: 100)
                            .clipped()

                            Picker("Inches", selection: $heightInches) {
                                ForEach(0...11, id: \.self) { inch in
                                    Text("\(inch) in").tag(inch)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 100, height: 100)
                            .clipped()
                        }
                    }

                    // Weight
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Weight: \(Int(weightPounds)) lbs")
                            .font(.headline)
                        Slider(value: $weightPounds, in: 80...400, step: 1)
                            .tint(.blue)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                Spacer()

                Button(action: {
                    withAnimation {
                        currentStep = 1
                    }
                }) {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding()
        }
    }

    // MARK: - Step 1: Fitness Goal
    private var fitnessGoalView: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "target")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)

                Text("What's Your Goal?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)

                Text("We'll tailor your workout plan to help you achieve it")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                VStack(spacing: 12) {
                    ForEach(FitnessGoal.allCases) { goal in
                        GoalSelectionCard(
                            goal: goal,
                            isSelected: selectedGoal == goal,
                            onTap: { selectedGoal = goal }
                        )
                    }
                }

                // Experience Level
                VStack(alignment: .leading, spacing: 12) {
                    Text("Experience Level")
                        .font(.headline)

                    ForEach(ExperienceLevel.allCases) { level in
                        ExperienceLevelCard(
                            level: level,
                            isSelected: experienceLevel == level,
                            onTap: { experienceLevel = level }
                        )
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                HStack {
                    Button(action: {
                        withAnimation {
                            currentStep = 0
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                        }
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button(action: {
                        withAnimation {
                            currentStep = 2
                        }
                    }) {
                        HStack {
                            Text("Continue")
                            Image(systemName: "arrow.right")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
    }

    // MARK: - Step 2: Frequency Selection
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

            HStack {
                Button(action: {
                    withAnimation {
                        currentStep = 1
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                }
                .buttonStyle(.bordered)

                Spacer()

                Button(action: {
                    withAnimation {
                        currentStep = 3
                    }
                }) {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding()
    }

    // MARK: - Step 3: Duration Selection
    private var durationSelectionView: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)
                    .padding(.top)

                Text("How long should each\nworkout be?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)

                // Duration selector
                VStack(spacing: 12) {
                    ForEach(WorkoutDuration.allCases) { duration in
                        DurationSelectionCard(
                            duration: duration,
                            isSelected: workoutDuration == duration,
                            onTap: { workoutDuration = duration }
                        )
                    }
                }

                // Advanced Options (collapsible)
                VStack(spacing: 12) {
                    Button(action: {
                        withAnimation {
                            showAdvancedOptions.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .foregroundStyle(.purple)
                            Text("Advanced Options")
                                .font(.headline)
                                .foregroundStyle(.primary)
                            Spacer()
                            Image(systemName: showAdvancedOptions ? "chevron.up" : "chevron.down")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .buttonStyle(.plain)

                    if showAdvancedOptions {
                        VStack(alignment: .leading, spacing: 16) {
                            // Workout Split
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Workout Split")
                                    .font(.subheadline)
                                    .fontWeight(.medium)

                                ForEach(WorkoutSplit.allCases) { split in
                                    SplitSelectionCard(
                                        split: split,
                                        isSelected: workoutSplit == split,
                                        onTap: { workoutSplit = split }
                                    )
                                }
                            }

                            Divider()

                            // Muscle Frequency
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Muscle Group Frequency")
                                    .font(.subheadline)
                                    .fontWeight(.medium)

                                ForEach(MuscleFrequency.allCases) { frequency in
                                    FrequencySelectionCard(
                                        frequency: frequency,
                                        isSelected: muscleFrequency == frequency,
                                        isRecommended: frequency == .twicePerWeek,
                                        onTap: { muscleFrequency = frequency }
                                    )
                                }
                            }
                        }
                        .padding()
                        .background(Color.purple.opacity(0.05))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.purple.opacity(0.2), lineWidth: 1)
                        )
                    }
                }

                Spacer(minLength: 20)

                HStack {
                    Button(action: {
                        withAnimation {
                            currentStep = 2
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                        }
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button(action: {
                        generatePlans()
                    }) {
                        HStack {
                            Text("Generate Plan")
                            Image(systemName: "sparkles")
                        }
                        .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isGenerating)
                }
                .padding(.bottom)
            }
            .padding()
        }
    }

    private var recommendationText: String {
        let cardioPercent = Int(selectedGoal.cardioRatio * 100)
        let strengthPercent = 100 - cardioPercent

        return "Based on your goal to \(selectedGoal.rawValue.lowercased()), your plan will include ~\(strengthPercent)% strength training and ~\(cardioPercent)% cardio."
    }

    // MARK: - Step 4: Plan Preview
    private var planPreviewView: some View {
        VStack(spacing: 16) {
            Text("Your Personalized Plan")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            // Goal and duration summary
            HStack(spacing: 12) {
                HStack {
                    Image(systemName: selectedGoal.icon)
                        .foregroundStyle(.blue)
                    Text(selectedGoal.rawValue)
                        .font(.subheadline)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)

                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(.orange)
                    Text(workoutDuration.displayName)
                        .font(.subheadline)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(8)
            }

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array(generatedPlans.enumerated()), id: \.element.id) { index, plan in
                        GeneratedPlanCardWithRationale(
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
                    currentStep = 3
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                }
                .buttonStyle(.bordered)

                Spacer()

                Button(action: {
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
                    currentStep = 5
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

    // MARK: - Step 5: Confirmation
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

                HStack {
                    Image(systemName: selectedGoal.icon)
                        .foregroundStyle(.blue)
                    Text("Goal: \(selectedGoal.rawValue)")
                }

                Text("\(daysPerWeek) days per week • \(workoutDuration.displayName) each")
                Text("\(generatedPlans.flatMap { $0.exercises }.count) total exercises")
                Text("Est. \(generatedPlans.reduce(0) { $0 + $1.estimatedCalories }) calories per week")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)

            Spacer()

            HStack {
                Button(action: {
                    currentStep = 4
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
                planName = "My \(selectedGoal.rawValue) Plan"
            }
        }
    }

    // MARK: - Functions
    private func generatePlans() {
        isGenerating = true

        // Create or update user profile
        let profile: UserProfile
        if let existingProfile = existingProfiles.first {
            existingProfile.dateOfBirth = dateOfBirth
            existingProfile.gender = gender.rawValue
            existingProfile.heightInches = heightInInches
            existingProfile.weightPounds = weightPounds
            existingProfile.fitnessGoal = selectedGoal.rawValue
            existingProfile.experienceLevel = experienceLevel.rawValue
            existingProfile.workoutDurationMinutes = workoutDuration.rawValue
            existingProfile.workoutSplit = workoutSplit.rawValue
            existingProfile.muscleFrequency = muscleFrequency.rawValue
            existingProfile.updatedDate = Date()
            profile = existingProfile
        } else {
            profile = UserProfile(
                dateOfBirth: dateOfBirth,
                gender: gender,
                heightInches: heightInInches,
                weightPounds: weightPounds,
                fitnessGoal: selectedGoal,
                experienceLevel: experienceLevel,
                workoutDuration: workoutDuration,
                workoutSplit: workoutSplit,
                muscleFrequency: muscleFrequency
            )
            modelContext.insert(profile)
        }

        // Generate personalized plans
        generatedPlans = WorkoutPlanGenerator.generatePersonalizedPlans(profile: profile, daysPerWeek: daysPerWeek)
        selectedPlans = Set(generatedPlans.map { $0.id })
        isGenerating = false
        currentStep = 4
    }

    private func savePlans() {
        // First, deactivate all existing plans (move to "Previous Plans")
        for existingPlan in existingCustomPlans {
            existingPlan.isActive = false
        }

        // Then create the new plans as active
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

// MARK: - Goal Selection Card
struct GoalSelectionCard: View {
    let goal: FitnessGoal
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                Image(systemName: goal.icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? .white : .blue)
                    .frame(width: 44, height: 44)
                    .background(isSelected ? Color.blue : Color.blue.opacity(0.1))
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 4) {
                    Text(goal.rawValue)
                        .font(.headline)
                        .foregroundStyle(isSelected ? .white : .primary)

                    Text(goal.description)
                        .font(.caption)
                        .foregroundStyle(isSelected ? .white.opacity(0.8) : .secondary)
                        .lineLimit(2)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.white)
                }
            }
            .padding()
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Experience Level Card
struct ExperienceLevelCard: View {
    let level: ExperienceLevel
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(level.rawValue)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(isSelected ? .blue : .primary)

                    Text(level.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.blue)
                }
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemBackground))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Duration Selection Card
struct DurationSelectionCard: View {
    let duration: WorkoutDuration
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(duration.displayName)
                        .font(.headline)
                        .foregroundStyle(isSelected ? .blue : .primary)

                    Text(duration.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("~\(duration.exerciseCount) exercises")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text("+\(duration.cardioMinutes) min cardio")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.blue)
                }
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemGray6))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Split Selection Card
struct SplitSelectionCard: View {
    let split: WorkoutSplit
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: split.icon)
                    .font(.title3)
                    .foregroundStyle(isSelected ? .purple : .secondary)
                    .frame(width: 30)

                VStack(alignment: .leading, spacing: 2) {
                    Text(split.rawValue)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(isSelected ? .purple : .primary)

                    Text(split.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.purple)
                }
            }
            .padding(12)
            .background(isSelected ? Color.purple.opacity(0.1) : Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Frequency Selection Card
struct FrequencySelectionCard: View {
    let frequency: MuscleFrequency
    let isSelected: Bool
    var isRecommended: Bool = false
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text(frequency.displayName)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(isSelected ? .purple : .primary)

                        if isRecommended {
                            Text("Recommended")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.green)
                                .cornerRadius(4)
                        }
                    }

                    Text(frequency.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.purple)
                }
            }
            .padding(12)
            .background(isSelected ? Color.purple.opacity(0.1) : Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Generated Plan Card with Rationale
struct GeneratedPlanCardWithRationale: View {
    let dayNumber: Int
    let plan: GeneratedWorkoutDay
    let isSelected: Bool
    let onTap: () -> Void

    @State private var isExpanded: Bool = false
    @State private var showRationale: Bool = false

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
                            .fill(plan.isCardioDay ? Color.orange.opacity(0.1) : Color.blue.opacity(0.1))
                            .frame(width: 44, height: 44)

                        VStack(spacing: 0) {
                            Text("Day")
                                .font(.caption2)
                            Text("\(dayNumber)")
                                .font(.caption)
                                .fontWeight(.bold)
                        }
                        .foregroundStyle(plan.isCardioDay ? .orange : .blue)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text(plan.name)
                                .font(.headline)
                                .foregroundStyle(.primary)

                            if plan.isCardioDay {
                                Text("CARDIO")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.orange.opacity(0.2))
                                    .foregroundStyle(.orange)
                                    .cornerRadius(4)
                            }
                        }

                        Text(plan.description)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text("\(plan.exercises.count) exercises")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text("~\(plan.estimatedCalories) cal")
                            .font(.caption)
                            .foregroundStyle(.orange)
                    }

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)

            if isExpanded {
                Divider()

                // Rationale section
                if !plan.rationale.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "lightbulb.fill")
                                .foregroundStyle(.yellow)
                            Text("Why this workout?")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }

                        Text(plan.rationale)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(8)
                }

                // Exercises list
                ForEach(plan.exercises) { exercise in
                    HStack {
                        Image(systemName: exercise.imageName)
                            .foregroundStyle(exercise.isCardio ? .orange : .blue)
                            .frame(width: 24)

                        Text(exercise.name)
                            .font(.subheadline)

                        Spacer()

                        if exercise.isCardio {
                            Text("\(exercise.defaultReps) min")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("\(exercise.defaultSets)x\(exercise.defaultReps)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
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

// Keep the old card for backward compatibility
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

                        Text("\(exercise.defaultSets)x\(exercise.defaultReps)")
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
        .modelContainer(for: [CustomWorkoutPlan.self, WorkoutSession.self, ExerciseSet.self, UserProfile.self], inMemory: true)
}
