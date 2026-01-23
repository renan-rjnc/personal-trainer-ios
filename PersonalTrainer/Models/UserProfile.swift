import Foundation
import SwiftData

// MARK: - Fitness Goals
enum FitnessGoal: String, Codable, CaseIterable, Identifiable {
    case loseWeight = "Lose Weight"
    case buildMuscle = "Build Muscle"
    case improveEndurance = "Improve Endurance"
    case generalFitness = "General Fitness"
    case increaseStrength = "Increase Strength"
    case toneUp = "Tone & Define"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .loseWeight: return "flame.fill"
        case .buildMuscle: return "figure.strengthtraining.traditional"
        case .improveEndurance: return "figure.run"
        case .generalFitness: return "heart.fill"
        case .increaseStrength: return "dumbbell.fill"
        case .toneUp: return "figure.mixed.cardio"
        }
    }

    var description: String {
        switch self {
        case .loseWeight:
            return "Burn fat with high-intensity cardio and metabolic training"
        case .buildMuscle:
            return "Hypertrophy-focused weight training for muscle growth"
        case .improveEndurance:
            return "Cardio-heavy program to boost stamina and heart health"
        case .generalFitness:
            return "Balanced mix of strength, cardio, and flexibility"
        case .increaseStrength:
            return "Heavy compound lifts for maximum strength gains"
        case .toneUp:
            return "Moderate weights with higher reps for definition"
        }
    }

    var cardioRatio: Double {
        switch self {
        case .loseWeight: return 0.5        // 50% cardio
        case .buildMuscle: return 0.1       // 10% cardio
        case .improveEndurance: return 0.7  // 70% cardio
        case .generalFitness: return 0.3    // 30% cardio
        case .increaseStrength: return 0.1  // 10% cardio
        case .toneUp: return 0.3            // 30% cardio
        }
    }

    var recommendedSetsRange: ClosedRange<Int> {
        switch self {
        case .loseWeight: return 3...4
        case .buildMuscle: return 4...5
        case .improveEndurance: return 2...3
        case .generalFitness: return 3...4
        case .increaseStrength: return 4...5
        case .toneUp: return 3...4
        }
    }

    var recommendedRepsRange: ClosedRange<Int> {
        switch self {
        case .loseWeight: return 12...15
        case .buildMuscle: return 8...12
        case .improveEndurance: return 15...20
        case .generalFitness: return 10...12
        case .increaseStrength: return 4...6
        case .toneUp: return 12...15
        }
    }
}

// MARK: - Gender
enum Gender: String, Codable, CaseIterable, Identifiable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
    case preferNotToSay = "Prefer not to say"

    var id: String { rawValue }
}

// MARK: - Experience Level
enum ExperienceLevel: String, Codable, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .beginner: return "New to working out (0-6 months)"
        case .intermediate: return "Some experience (6 months - 2 years)"
        case .advanced: return "Experienced lifter (2+ years)"
        }
    }
}

// MARK: - Workout Duration Preference
enum WorkoutDuration: Int, Codable, CaseIterable, Identifiable {
    case short = 30      // 30 minutes
    case medium = 45     // 45 minutes
    case standard = 60   // 60 minutes
    case long = 75       // 75 minutes
    case extended = 90   // 90 minutes

    var id: Int { rawValue }

    var displayName: String {
        switch self {
        case .short: return "30 min"
        case .medium: return "45 min"
        case .standard: return "60 min"
        case .long: return "75 min"
        case .extended: return "90 min"
        }
    }

    var description: String {
        switch self {
        case .short: return "Quick & efficient"
        case .medium: return "Balanced session"
        case .standard: return "Full workout"
        case .long: return "Thorough training"
        case .extended: return "Extended session"
        }
    }

    // Approximate number of strength exercises for this duration (excluding cardio finisher)
    var exerciseCount: Int {
        switch self {
        case .short: return 4
        case .medium: return 6
        case .standard: return 7
        case .long: return 8
        case .extended: return 10
        }
    }

    // Minutes of cardio to add at the end
    var cardioMinutes: Int {
        switch self {
        case .short: return 5
        case .medium: return 8
        case .standard: return 10
        case .long: return 12
        case .extended: return 15
        }
    }
}

// MARK: - Workout Split Preference
enum WorkoutSplit: String, Codable, CaseIterable, Identifiable {
    case fullBody = "Full Body"
    case upperLower = "Upper/Lower Split"
    case pushPullLegs = "Push/Pull/Legs"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .fullBody:
            return "Train upper and lower body together each session"
        case .upperLower:
            return "Alternate between upper and lower body days"
        case .pushPullLegs:
            return "Separate push, pull, and leg days"
        }
    }

    var icon: String {
        switch self {
        case .fullBody: return "figure.strengthtraining.traditional"
        case .upperLower: return "arrow.up.arrow.down"
        case .pushPullLegs: return "arrow.left.arrow.right"
        }
    }

    // Minimum days per week recommended for this split
    var minDaysRecommended: Int {
        switch self {
        case .fullBody: return 2
        case .upperLower: return 3
        case .pushPullLegs: return 3
        }
    }
}

// MARK: - Muscle Group Frequency
enum MuscleFrequency: Int, Codable, CaseIterable, Identifiable {
    case oncePerWeek = 1
    case twicePerWeek = 2
    case threeTimesPerWeek = 3

    var id: Int { rawValue }

    var displayName: String {
        switch self {
        case .oncePerWeek: return "1x per week"
        case .twicePerWeek: return "2x per week"
        case .threeTimesPerWeek: return "3x per week"
        }
    }

    var description: String {
        switch self {
        case .oncePerWeek:
            return "Each muscle group trained once (traditional bodybuilding)"
        case .twicePerWeek:
            return "Each muscle group trained twice (recommended for most)"
        case .threeTimesPerWeek:
            return "High frequency training (advanced)"
        }
    }
}

// MARK: - User Profile Model
@Model
final class UserProfile {
    var id: UUID
    var dateOfBirth: Date
    var gender: String
    var heightInches: Double  // Store in inches for easier calculations
    var weightPounds: Double  // Store in pounds
    var fitnessGoal: String
    var experienceLevel: String
    var workoutDurationMinutes: Int = 60  // Target workout duration (default: 60 min)
    var workoutSplit: String = "Full Body"  // Default to full body (upper+lower together)
    var muscleFrequency: Int = 2  // Default to 2x per week per muscle group
    var createdDate: Date
    var updatedDate: Date

    init(
        id: UUID = UUID(),
        dateOfBirth: Date,
        gender: Gender,
        heightInches: Double,
        weightPounds: Double,
        fitnessGoal: FitnessGoal,
        experienceLevel: ExperienceLevel = .beginner,
        workoutDuration: WorkoutDuration = .standard,
        workoutSplit: WorkoutSplit = .fullBody,
        muscleFrequency: MuscleFrequency = .twicePerWeek
    ) {
        self.id = id
        self.dateOfBirth = dateOfBirth
        self.gender = gender.rawValue
        self.heightInches = heightInches
        self.weightPounds = weightPounds
        self.fitnessGoal = fitnessGoal.rawValue
        self.experienceLevel = experienceLevel.rawValue
        self.workoutDurationMinutes = workoutDuration.rawValue
        self.workoutSplit = workoutSplit.rawValue
        self.muscleFrequency = muscleFrequency.rawValue
        self.createdDate = Date()
        self.updatedDate = Date()
    }

    // MARK: - Computed Properties
    var age: Int {
        Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
    }

    var genderEnum: Gender {
        Gender(rawValue: gender) ?? .preferNotToSay
    }

    var goalEnum: FitnessGoal {
        FitnessGoal(rawValue: fitnessGoal) ?? .generalFitness
    }

    var experienceEnum: ExperienceLevel {
        ExperienceLevel(rawValue: experienceLevel) ?? .beginner
    }

    var workoutDurationEnum: WorkoutDuration {
        WorkoutDuration(rawValue: workoutDurationMinutes) ?? .standard
    }

    var workoutSplitEnum: WorkoutSplit {
        WorkoutSplit(rawValue: workoutSplit) ?? .fullBody
    }

    var muscleFrequencyEnum: MuscleFrequency {
        MuscleFrequency(rawValue: muscleFrequency) ?? .twicePerWeek
    }

    var heightFeet: Int {
        Int(heightInches / 12)
    }

    var heightRemainingInches: Int {
        Int(heightInches.truncatingRemainder(dividingBy: 12))
    }

    var formattedHeight: String {
        "\(heightFeet)'\(heightRemainingInches)\""
    }

    var formattedWeight: String {
        "\(Int(weightPounds)) lbs"
    }

    // BMI Calculation
    var bmi: Double {
        // BMI = (weight in pounds × 703) / (height in inches)²
        guard heightInches > 0 else { return 0 }
        return (weightPounds * 703) / (heightInches * heightInches)
    }

    var bmiCategory: String {
        switch bmi {
        case ..<18.5: return "Underweight"
        case 18.5..<25: return "Normal"
        case 25..<30: return "Overweight"
        default: return "Obese"
        }
    }

    // MARK: - Workout Recommendations
    var recommendedRestTime: Int {
        switch goalEnum {
        case .loseWeight, .improveEndurance:
            return 30 // seconds
        case .buildMuscle, .toneUp:
            return 60
        case .increaseStrength:
            return 120
        case .generalFitness:
            return 60
        }
    }

    var recommendedWorkoutDuration: Int {
        switch goalEnum {
        case .loseWeight:
            return 45
        case .buildMuscle:
            return 60
        case .improveEndurance:
            return 40
        case .generalFitness:
            return 45
        case .increaseStrength:
            return 60
        case .toneUp:
            return 50
        }
    }

    // Calculate recommended calories to burn per workout
    var recommendedCaloriesBurn: Int {
        let baseCalories: Int
        switch goalEnum {
        case .loseWeight: baseCalories = 400
        case .buildMuscle: baseCalories = 300
        case .improveEndurance: baseCalories = 350
        case .generalFitness: baseCalories = 300
        case .increaseStrength: baseCalories = 250
        case .toneUp: baseCalories = 350
        }

        // Adjust based on weight
        let weightMultiplier = weightPounds / 150.0
        return Int(Double(baseCalories) * weightMultiplier)
    }
}
