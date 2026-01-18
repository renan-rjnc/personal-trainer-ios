import Foundation

struct WorkoutPlanGenerator {
    // MARK: - All Available Exercises (expanded library)
    static let allExercises: [Exercise] = [
        // Chest
        Exercise(name: "Bench Press", muscleGroups: ["Chest", "Triceps", "Shoulders"],
                 instructions: "Lie on a flat bench with feet firmly on the ground. Grip the bar slightly wider than shoulder-width. Lower the bar to your mid-chest, then press back up to full arm extension.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 4, defaultReps: 8),
        Exercise(name: "Incline Dumbbell Press", muscleGroups: ["Upper Chest", "Shoulders", "Triceps"],
                 instructions: "Set bench to 30-45 degree incline. Hold dumbbells at shoulder level with palms facing forward. Press weights up until arms are extended.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),
        Exercise(name: "Dumbbell Flyes", muscleGroups: ["Chest"],
                 instructions: "Lie on a flat bench with dumbbells above chest, palms facing each other. Lower weights out to sides with slight elbow bend, then squeeze back together.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Push-Ups", muscleGroups: ["Chest", "Triceps", "Shoulders"],
                 instructions: "Start in plank position with hands slightly wider than shoulders. Lower chest to ground, then push back up. Keep core tight throughout.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 15),
        Exercise(name: "Cable Crossover", muscleGroups: ["Chest"],
                 instructions: "Stand between cable machines with handles at high position. Step forward, bring handles together in front of chest with slight elbow bend.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),

        // Back
        Exercise(name: "Deadlift", muscleGroups: ["Back", "Hamstrings", "Glutes"],
                 instructions: "Stand with feet hip-width apart, bar over mid-foot. Hinge at hips and grip the bar. Keep back flat, drive through heels and extend hips and knees.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 4, defaultReps: 6),
        Exercise(name: "Pull-Ups", muscleGroups: ["Back", "Biceps"],
                 instructions: "Hang from a bar with palms facing away. Pull yourself up until chin clears the bar. Lower with control.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 8),
        Exercise(name: "Barbell Rows", muscleGroups: ["Back", "Biceps"],
                 instructions: "Bend at hips with slight knee bend, back flat. Pull bar to lower chest, squeezing shoulder blades together.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 4, defaultReps: 8),
        Exercise(name: "Lat Pulldown", muscleGroups: ["Back", "Biceps"],
                 instructions: "Sit at the lat pulldown machine and grip the bar wider than shoulder-width. Pull the bar down to your upper chest while squeezing your lats.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),
        Exercise(name: "Seated Cable Row", muscleGroups: ["Back", "Biceps"],
                 instructions: "Sit at cable row machine, feet on platform. Pull handle to lower chest, squeezing shoulder blades together. Return with control.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),
        Exercise(name: "Face Pulls", muscleGroups: ["Rear Delts", "Upper Back"],
                 instructions: "Set cable at face height with rope attachment. Pull toward your face, separating the rope ends. Squeeze shoulder blades together.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 15),
        Exercise(name: "Dumbbell Rows", muscleGroups: ["Back", "Biceps"],
                 instructions: "Place one knee and hand on bench, other foot on floor. Pull dumbbell to hip, squeezing back at top. Lower with control.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),

        // Shoulders
        Exercise(name: "Overhead Press", muscleGroups: ["Shoulders", "Triceps"],
                 instructions: "Stand with feet shoulder-width apart. Hold the barbell at shoulder height. Press the bar overhead until arms are fully extended.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),
        Exercise(name: "Lateral Raises", muscleGroups: ["Shoulders"],
                 instructions: "Stand with dumbbells at your sides. Raise arms out to the sides until parallel with the ground. Lower with control.",
                 imageName: "figure.arms.open", defaultSets: 3, defaultReps: 15),
        Exercise(name: "Front Raises", muscleGroups: ["Shoulders"],
                 instructions: "Stand with dumbbells in front of thighs. Raise one or both arms straight in front to shoulder height. Lower with control.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Arnold Press", muscleGroups: ["Shoulders", "Triceps"],
                 instructions: "Start with dumbbells at shoulder height, palms facing you. Rotate palms outward as you press overhead. Reverse on the way down.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),
        Exercise(name: "Reverse Flyes", muscleGroups: ["Rear Delts", "Upper Back"],
                 instructions: "Bend forward at hips with dumbbells hanging down. Raise arms out to sides, squeezing shoulder blades together.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),

        // Arms - Biceps
        Exercise(name: "Bicep Curls", muscleGroups: ["Biceps"],
                 instructions: "Stand with dumbbells at your sides, palms facing forward. Curl the weights up toward your shoulders, keeping elbows stationary.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Hammer Curls", muscleGroups: ["Biceps", "Forearms"],
                 instructions: "Stand with dumbbells at your sides, palms facing each other. Curl the weights up while maintaining the neutral grip.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Preacher Curls", muscleGroups: ["Biceps"],
                 instructions: "Sit at preacher bench with arms over pad. Curl weight up, squeezing biceps at top. Lower with control.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),
        Exercise(name: "Incline Dumbbell Curls", muscleGroups: ["Biceps"],
                 instructions: "Sit on incline bench with dumbbells hanging at sides. Curl weights up without moving upper arms. Squeeze at top.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),

        // Arms - Triceps
        Exercise(name: "Tricep Dips", muscleGroups: ["Triceps", "Chest", "Shoulders"],
                 instructions: "Grip parallel bars and lift yourself up. Lower your body by bending elbows until upper arms are parallel to ground. Push back up.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Tricep Pushdown", muscleGroups: ["Triceps"],
                 instructions: "Stand facing cable machine with straight or rope attachment. Keep elbows pinned to sides and push weight down until arms are extended.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Skull Crushers", muscleGroups: ["Triceps"],
                 instructions: "Lie on bench with barbell or dumbbells above chest. Bend elbows to lower weight toward forehead. Extend arms back up.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),
        Exercise(name: "Overhead Tricep Extension", muscleGroups: ["Triceps"],
                 instructions: "Hold dumbbell overhead with both hands. Lower weight behind head by bending elbows. Extend arms back up.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),

        // Legs - Quads
        Exercise(name: "Barbell Squats", muscleGroups: ["Quads", "Glutes", "Hamstrings"],
                 instructions: "Position bar on upper back. Stand with feet shoulder-width apart. Squat down until thighs are parallel to ground. Drive through heels to stand.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 4, defaultReps: 8),
        Exercise(name: "Leg Press", muscleGroups: ["Quads", "Glutes", "Hamstrings"],
                 instructions: "Sit in leg press machine with feet shoulder-width on platform. Lower weight by bending knees to 90 degrees. Press back up.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 4, defaultReps: 10),
        Exercise(name: "Leg Extensions", muscleGroups: ["Quads"],
                 instructions: "Sit in leg extension machine with pad on lower shins. Extend legs until straight, squeezing quads at top.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Walking Lunges", muscleGroups: ["Quads", "Glutes", "Hamstrings"],
                 instructions: "Step forward into a lunge, lowering until both knees are at 90 degrees. Push off front foot and step forward into next lunge.",
                 imageName: "figure.walk", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Bulgarian Split Squats", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Stand with rear foot elevated on bench. Lower into lunge until front thigh is parallel to ground. Push through front heel to stand.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),
        Exercise(name: "Goblet Squats", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Hold dumbbell or kettlebell at chest. Squat down keeping chest up and elbows inside knees. Drive through heels to stand.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),

        // Legs - Hamstrings & Glutes
        Exercise(name: "Romanian Deadlift", muscleGroups: ["Hamstrings", "Glutes", "Lower Back"],
                 instructions: "Hold barbell with overhand grip. Keep legs slightly bent. Hinge at hips, lowering bar along legs until hamstring stretch. Drive hips forward.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),
        Exercise(name: "Leg Curls", muscleGroups: ["Hamstrings"],
                 instructions: "Lie face down on leg curl machine with pad above heels. Curl weight up by bending knees, squeezing hamstrings at top.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Hip Thrusts", muscleGroups: ["Glutes", "Hamstrings"],
                 instructions: "Sit with upper back against bench, barbell over hips. Drive through heels and squeeze glutes to lift hips until body forms straight line.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Glute Bridges", muscleGroups: ["Glutes", "Hamstrings"],
                 instructions: "Lie on back with knees bent, feet flat on floor. Squeeze glutes to lift hips until body forms straight line. Lower with control.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 15),
        Exercise(name: "Good Mornings", muscleGroups: ["Hamstrings", "Lower Back", "Glutes"],
                 instructions: "Stand with barbell on upper back. Hinge at hips, pushing them back while keeping back flat. Return to standing.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 10),

        // Legs - Calves
        Exercise(name: "Calf Raises", muscleGroups: ["Calves"],
                 instructions: "Stand on edge of step with heels hanging off. Rise up onto toes as high as possible. Lower heels below step level for full stretch.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 4, defaultReps: 15),
        Exercise(name: "Seated Calf Raises", muscleGroups: ["Calves"],
                 instructions: "Sit at seated calf raise machine with pad on knees. Rise up onto toes, squeezing calves at top. Lower with control.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 15),

        // Core
        Exercise(name: "Planks", muscleGroups: ["Core"],
                 instructions: "Start in forearm plank position with body in straight line. Hold position, engaging core and glutes. Don't let hips sag or pike.",
                 imageName: "figure.core.training", defaultSets: 3, defaultReps: 60),
        Exercise(name: "Cable Crunches", muscleGroups: ["Core"],
                 instructions: "Kneel facing cable machine with rope attachment. Crunch down, bringing elbows toward knees while contracting abs.",
                 imageName: "figure.core.training", defaultSets: 3, defaultReps: 15),
        Exercise(name: "Hanging Leg Raises", muscleGroups: ["Core", "Hip Flexors"],
                 instructions: "Hang from pull-up bar. Raise legs until parallel to ground or higher, keeping them straight. Lower with control.",
                 imageName: "figure.strengthtraining.traditional", defaultSets: 3, defaultReps: 12),
        Exercise(name: "Russian Twists", muscleGroups: ["Core", "Obliques"],
                 instructions: "Sit with knees bent, lean back slightly. Hold weight at chest and rotate torso side to side, touching weight to ground each side.",
                 imageName: "figure.core.training", defaultSets: 3, defaultReps: 20),
    ]

    // MARK: - Exercise Categories
    static let chestExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Chest") || $0.muscleGroups.contains("Upper Chest") }
    static let backExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Back") || $0.muscleGroups.contains("Upper Back") }
    static let shoulderExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Shoulders") || $0.muscleGroups.contains("Rear Delts") }
    static let bicepExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Biceps") }
    static let tricepExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Triceps") && !$0.muscleGroups.contains("Chest") }
    static let quadExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Quads") }
    static let hamstringExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Hamstrings") && !$0.muscleGroups.contains("Quads") }
    static let gluteExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Glutes") && !$0.muscleGroups.contains("Quads") }
    static let calfExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Calves") }
    static let coreExercises: [Exercise] = allExercises.filter { $0.muscleGroups.contains("Core") }

    // MARK: - Generate Plans Based on Frequency
    static func generatePlans(daysPerWeek: Int) -> [GeneratedWorkoutDay] {
        switch daysPerWeek {
        case 2:
            return generateTwoDaySplit()
        case 3:
            return generateThreeDaySplit()
        case 4:
            return generateFourDaySplit()
        case 5:
            return generateFiveDaySplit()
        case 6:
            return generateSixDaySplit()
        default:
            return generateThreeDaySplit()
        }
    }

    // MARK: - Split Routines
    private static func generateTwoDaySplit() -> [GeneratedWorkoutDay] {
        [
            GeneratedWorkoutDay(
                name: "Upper Body",
                description: "Chest, back, shoulders, and arms",
                exercises: selectExercises([
                    (chestExercises, 2),
                    (backExercises, 2),
                    (shoulderExercises, 2),
                    (bicepExercises, 1),
                    (tricepExercises, 1)
                ]),
                iconName: "figure.arms.open"
            ),
            GeneratedWorkoutDay(
                name: "Lower Body",
                description: "Quads, hamstrings, glutes, and calves",
                exercises: selectExercises([
                    (quadExercises, 3),
                    (hamstringExercises, 2),
                    (gluteExercises, 1),
                    (calfExercises, 1),
                    (coreExercises, 1)
                ]),
                iconName: "figure.walk"
            )
        ]
    }

    private static func generateThreeDaySplit() -> [GeneratedWorkoutDay] {
        [
            GeneratedWorkoutDay(
                name: "Push",
                description: "Chest, shoulders, and triceps",
                exercises: selectExercises([
                    (chestExercises, 3),
                    (shoulderExercises, 2),
                    (tricepExercises, 2)
                ]),
                iconName: "arrow.up.circle.fill"
            ),
            GeneratedWorkoutDay(
                name: "Pull",
                description: "Back and biceps",
                exercises: selectExercises([
                    (backExercises, 4),
                    (bicepExercises, 2),
                    (shoulderExercises.filter { $0.muscleGroups.contains("Rear Delts") }, 1)
                ]),
                iconName: "arrow.down.circle.fill"
            ),
            GeneratedWorkoutDay(
                name: "Legs",
                description: "Quads, hamstrings, glutes, and calves",
                exercises: selectExercises([
                    (quadExercises, 3),
                    (hamstringExercises, 2),
                    (gluteExercises, 1),
                    (calfExercises, 1),
                    (coreExercises, 1)
                ]),
                iconName: "figure.walk.circle.fill"
            )
        ]
    }

    private static func generateFourDaySplit() -> [GeneratedWorkoutDay] {
        [
            GeneratedWorkoutDay(
                name: "Upper Body A",
                description: "Chest and back focus",
                exercises: selectExercises([
                    (chestExercises, 3),
                    (backExercises, 3),
                    (bicepExercises, 1),
                    (tricepExercises, 1)
                ]),
                iconName: "figure.arms.open"
            ),
            GeneratedWorkoutDay(
                name: "Lower Body A",
                description: "Quad and glute focus",
                exercises: selectExercises([
                    (quadExercises, 3),
                    (gluteExercises, 2),
                    (calfExercises, 1),
                    (coreExercises, 2)
                ]),
                iconName: "figure.walk"
            ),
            GeneratedWorkoutDay(
                name: "Upper Body B",
                description: "Shoulders and arms focus",
                exercises: selectExercises([
                    (shoulderExercises, 3),
                    (chestExercises, 1),
                    (backExercises, 1),
                    (bicepExercises, 2),
                    (tricepExercises, 2)
                ]),
                iconName: "figure.strengthtraining.traditional"
            ),
            GeneratedWorkoutDay(
                name: "Lower Body B",
                description: "Hamstring and posterior chain focus",
                exercises: selectExercises([
                    (hamstringExercises, 3),
                    (gluteExercises, 2),
                    (quadExercises, 1),
                    (calfExercises, 1),
                    (coreExercises, 1)
                ]),
                iconName: "figure.walk.circle.fill"
            )
        ]
    }

    private static func generateFiveDaySplit() -> [GeneratedWorkoutDay] {
        [
            GeneratedWorkoutDay(
                name: "Chest",
                description: "Chest focused workout",
                exercises: selectExercises([
                    (chestExercises, 4),
                    (tricepExercises, 2),
                    (coreExercises, 1)
                ]),
                iconName: "figure.strengthtraining.traditional"
            ),
            GeneratedWorkoutDay(
                name: "Back",
                description: "Back focused workout",
                exercises: selectExercises([
                    (backExercises, 5),
                    (bicepExercises, 2)
                ]),
                iconName: "figure.strengthtraining.traditional"
            ),
            GeneratedWorkoutDay(
                name: "Shoulders",
                description: "Shoulders focused workout",
                exercises: selectExercises([
                    (shoulderExercises, 4),
                    (tricepExercises, 2),
                    (coreExercises, 1)
                ]),
                iconName: "figure.arms.open"
            ),
            GeneratedWorkoutDay(
                name: "Legs",
                description: "Full leg workout",
                exercises: selectExercises([
                    (quadExercises, 3),
                    (hamstringExercises, 2),
                    (gluteExercises, 1),
                    (calfExercises, 2)
                ]),
                iconName: "figure.walk"
            ),
            GeneratedWorkoutDay(
                name: "Arms",
                description: "Biceps and triceps",
                exercises: selectExercises([
                    (bicepExercises, 3),
                    (tricepExercises, 3),
                    (coreExercises, 1)
                ]),
                iconName: "figure.strengthtraining.traditional"
            )
        ]
    }

    private static func generateSixDaySplit() -> [GeneratedWorkoutDay] {
        [
            GeneratedWorkoutDay(
                name: "Push A",
                description: "Chest focused push",
                exercises: selectExercises([
                    (chestExercises, 3),
                    (shoulderExercises, 2),
                    (tricepExercises, 2)
                ]),
                iconName: "arrow.up.circle.fill"
            ),
            GeneratedWorkoutDay(
                name: "Pull A",
                description: "Back width focus",
                exercises: selectExercises([
                    (backExercises.filter { $0.name.contains("Pull") || $0.name.contains("Lat") }, 2),
                    (backExercises, 2),
                    (bicepExercises, 2),
                    (shoulderExercises.filter { $0.muscleGroups.contains("Rear Delts") }, 1)
                ]),
                iconName: "arrow.down.circle.fill"
            ),
            GeneratedWorkoutDay(
                name: "Legs A",
                description: "Quad dominant",
                exercises: selectExercises([
                    (quadExercises, 4),
                    (gluteExercises, 1),
                    (calfExercises, 1),
                    (coreExercises, 1)
                ]),
                iconName: "figure.walk"
            ),
            GeneratedWorkoutDay(
                name: "Push B",
                description: "Shoulder focused push",
                exercises: selectExercises([
                    (shoulderExercises, 3),
                    (chestExercises, 2),
                    (tricepExercises, 2)
                ]),
                iconName: "arrow.up.circle.fill"
            ),
            GeneratedWorkoutDay(
                name: "Pull B",
                description: "Back thickness focus",
                exercises: selectExercises([
                    (backExercises.filter { $0.name.contains("Row") || $0.name.contains("Deadlift") }, 2),
                    (backExercises, 2),
                    (bicepExercises, 2),
                    (shoulderExercises.filter { $0.muscleGroups.contains("Rear Delts") }, 1)
                ]),
                iconName: "arrow.down.circle.fill"
            ),
            GeneratedWorkoutDay(
                name: "Legs B",
                description: "Hamstring dominant",
                exercises: selectExercises([
                    (hamstringExercises, 3),
                    (gluteExercises, 2),
                    (calfExercises, 1),
                    (coreExercises, 1)
                ]),
                iconName: "figure.walk.circle.fill"
            )
        ]
    }

    // MARK: - Helper Functions
    private static func selectExercises(_ categories: [(exercises: [Exercise], count: Int)]) -> [Exercise] {
        var selected: [Exercise] = []
        var usedNames: Set<String> = []

        for (exercises, count) in categories {
            let available = exercises.filter { !usedNames.contains($0.name) }
            let shuffled = available.shuffled()
            let toAdd = Array(shuffled.prefix(count))
            selected.append(contentsOf: toAdd)
            toAdd.forEach { usedNames.insert($0.name) }
        }

        return selected
    }

    // MARK: - Difficulty Adjustments
    static func adjustForDifficulty(_ exercises: [Exercise], difficulty: WorkoutDifficulty, feedback: DifficultyFeedback) -> [Exercise] {
        exercises.map { exercise in
            var adjusted = exercise
            switch feedback {
            case .tooEasy:
                // Increase sets or reps
                adjusted = Exercise(
                    id: exercise.id,
                    name: exercise.name,
                    muscleGroups: exercise.muscleGroups,
                    instructions: exercise.instructions,
                    imageName: exercise.imageName,
                    videoURL: exercise.videoURL,
                    defaultSets: min(exercise.defaultSets + 1, 5),
                    defaultReps: exercise.defaultReps + 2
                )
            case .tooHard:
                // Decrease sets or reps
                adjusted = Exercise(
                    id: exercise.id,
                    name: exercise.name,
                    muscleGroups: exercise.muscleGroups,
                    instructions: exercise.instructions,
                    imageName: exercise.imageName,
                    videoURL: exercise.videoURL,
                    defaultSets: max(exercise.defaultSets - 1, 2),
                    defaultReps: max(exercise.defaultReps - 2, 6)
                )
            case .justRight:
                break
            }
            return adjusted
        }
    }
}

// MARK: - Supporting Types
struct GeneratedWorkoutDay: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let exercises: [Exercise]
    let iconName: String

    var exerciseNames: [String] {
        exercises.map { $0.name }
    }

    var estimatedDuration: Int {
        exercises.count * 7 // ~7 minutes per exercise
    }
}

enum WorkoutDifficulty: String, Codable, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
}

enum DifficultyFeedback: String, Codable, CaseIterable {
    case tooEasy = "Too Easy"
    case justRight = "Just Right"
    case tooHard = "Too Hard"

    var emoji: String {
        switch self {
        case .tooEasy: return "😎"
        case .justRight: return "💪"
        case .tooHard: return "😓"
        }
    }

    var color: String {
        switch self {
        case .tooEasy: return "green"
        case .justRight: return "blue"
        case .tooHard: return "orange"
        }
    }
}
