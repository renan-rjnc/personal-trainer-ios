import Foundation

struct SampleWorkouts {
    // MARK: - Push Exercises
    static let benchPress = Exercise(
        name: "Bench Press",
        muscleGroups: ["Chest", "Triceps", "Shoulders"],
        instructions: "Lie on a flat bench with feet firmly on the ground. Grip the bar slightly wider than shoulder-width. Lower the bar to your mid-chest, then press back up to full arm extension. Keep your back slightly arched and shoulder blades pinched together.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 4,
        defaultReps: 8
    )

    static let overheadPress = Exercise(
        name: "Overhead Press",
        muscleGroups: ["Shoulders", "Triceps"],
        instructions: "Stand with feet shoulder-width apart. Hold the barbell at shoulder height with palms facing forward. Press the bar overhead until arms are fully extended. Lower back to starting position with control.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 10
    )

    static let inclineDumbbellPress = Exercise(
        name: "Incline Dumbbell Press",
        muscleGroups: ["Upper Chest", "Shoulders", "Triceps"],
        instructions: "Set bench to 30-45 degree incline. Hold dumbbells at shoulder level with palms facing forward. Press weights up until arms are extended, then lower with control.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 10
    )

    static let tricepDips = Exercise(
        name: "Tricep Dips",
        muscleGroups: ["Triceps", "Chest", "Shoulders"],
        instructions: "Grip parallel bars and lift yourself up. Lower your body by bending elbows until upper arms are parallel to the ground. Push back up to starting position. Keep elbows close to your body.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 12
    )

    static let lateralRaises = Exercise(
        name: "Lateral Raises",
        muscleGroups: ["Shoulders"],
        instructions: "Stand with dumbbells at your sides. Raise arms out to the sides until parallel with the ground, keeping a slight bend in elbows. Lower with control. Avoid using momentum.",
        imageName: "figure.arms.open",
        defaultSets: 3,
        defaultReps: 15
    )

    static let tricepPushdown = Exercise(
        name: "Tricep Pushdown",
        muscleGroups: ["Triceps"],
        instructions: "Stand facing a cable machine with a straight or rope attachment. Keep elbows pinned to your sides and push the weight down until arms are fully extended. Slowly return to starting position.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 12
    )

    // MARK: - Pull Exercises
    static let deadlift = Exercise(
        name: "Deadlift",
        muscleGroups: ["Back", "Hamstrings", "Glutes"],
        instructions: "Stand with feet hip-width apart, bar over mid-foot. Hinge at hips and grip the bar just outside your legs. Keep back flat, chest up. Drive through heels and extend hips and knees simultaneously.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 4,
        defaultReps: 6
    )

    static let pullUps = Exercise(
        name: "Pull-Ups",
        muscleGroups: ["Back", "Biceps"],
        instructions: "Hang from a bar with palms facing away, hands slightly wider than shoulder-width. Pull yourself up until chin clears the bar. Lower with control. Engage your lats, not just your arms.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 8
    )

    static let barbellRows = Exercise(
        name: "Barbell Rows",
        muscleGroups: ["Back", "Biceps"],
        instructions: "Bend at hips with slight knee bend, back flat. Grip barbell with hands shoulder-width apart. Pull bar to lower chest, squeezing shoulder blades together. Lower with control.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 4,
        defaultReps: 8
    )

    static let latPulldown = Exercise(
        name: "Lat Pulldown",
        muscleGroups: ["Back", "Biceps"],
        instructions: "Sit at the lat pulldown machine and grip the bar wider than shoulder-width. Pull the bar down to your upper chest while squeezing your lats. Slowly return to starting position.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 10
    )

    static let bicepCurls = Exercise(
        name: "Bicep Curls",
        muscleGroups: ["Biceps"],
        instructions: "Stand with dumbbells at your sides, palms facing forward. Curl the weights up toward your shoulders, keeping elbows stationary. Squeeze at the top and lower with control.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 12
    )

    static let hammerCurls = Exercise(
        name: "Hammer Curls",
        muscleGroups: ["Biceps", "Forearms"],
        instructions: "Stand with dumbbells at your sides, palms facing each other. Curl the weights up while maintaining the neutral grip. Squeeze at the top and lower with control.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 12
    )

    static let facepulls = Exercise(
        name: "Face Pulls",
        muscleGroups: ["Rear Delts", "Upper Back"],
        instructions: "Set cable at face height with rope attachment. Pull toward your face, separating the rope ends. Squeeze shoulder blades together and hold briefly. Return with control.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 15
    )

    // MARK: - Leg Exercises
    static let squats = Exercise(
        name: "Barbell Squats",
        muscleGroups: ["Quads", "Glutes", "Hamstrings"],
        instructions: "Position bar on upper back. Stand with feet shoulder-width apart. Squat down by bending knees and hips until thighs are parallel to ground. Drive through heels to stand.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 4,
        defaultReps: 8
    )

    static let legPress = Exercise(
        name: "Leg Press",
        muscleGroups: ["Quads", "Glutes", "Hamstrings"],
        instructions: "Sit in leg press machine with feet shoulder-width on platform. Lower the weight by bending knees to 90 degrees. Press back up without locking knees.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 4,
        defaultReps: 10
    )

    static let romanianDeadlift = Exercise(
        name: "Romanian Deadlift",
        muscleGroups: ["Hamstrings", "Glutes", "Lower Back"],
        instructions: "Hold barbell with overhand grip. Keep legs slightly bent. Hinge at hips, lowering bar along your legs until you feel a hamstring stretch. Drive hips forward to return.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 10
    )

    static let lunges = Exercise(
        name: "Walking Lunges",
        muscleGroups: ["Quads", "Glutes", "Hamstrings"],
        instructions: "Step forward into a lunge, lowering until both knees are at 90 degrees. Push off front foot and step forward into next lunge. Keep torso upright throughout.",
        imageName: "figure.walk",
        defaultSets: 3,
        defaultReps: 12
    )

    static let legCurls = Exercise(
        name: "Leg Curls",
        muscleGroups: ["Hamstrings"],
        instructions: "Lie face down on leg curl machine with pad above heels. Curl weight up by bending knees, squeezing hamstrings at top. Lower with control.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 12
    )

    static let legExtensions = Exercise(
        name: "Leg Extensions",
        muscleGroups: ["Quads"],
        instructions: "Sit in leg extension machine with pad on lower shins. Extend legs until straight, squeezing quads at top. Lower with control.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 12
    )

    static let calfRaises = Exercise(
        name: "Calf Raises",
        muscleGroups: ["Calves"],
        instructions: "Stand on edge of step with heels hanging off. Rise up onto toes as high as possible. Lower heels below step level for full stretch. Hold weight for added resistance.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 4,
        defaultReps: 15
    )

    static let hipThrusts = Exercise(
        name: "Hip Thrusts",
        muscleGroups: ["Glutes", "Hamstrings"],
        instructions: "Sit with upper back against bench, barbell over hips. Drive through heels and squeeze glutes to lift hips until body forms a straight line. Lower with control.",
        imageName: "figure.strengthtraining.traditional",
        defaultSets: 3,
        defaultReps: 12
    )

    // MARK: - Workout Plans
    static let pushDay = WorkoutPlan(
        name: "Push Day",
        description: "Chest, shoulders, and triceps focused workout",
        exercises: [benchPress, overheadPress, inclineDumbbellPress, lateralRaises, tricepDips, tricepPushdown],
        estimatedDuration: 50,
        iconName: "arrow.up.circle.fill"
    )

    static let pullDay = WorkoutPlan(
        name: "Pull Day",
        description: "Back and biceps focused workout",
        exercises: [deadlift, pullUps, barbellRows, latPulldown, bicepCurls, hammerCurls, facepulls],
        estimatedDuration: 55,
        iconName: "arrow.down.circle.fill"
    )

    static let legDay = WorkoutPlan(
        name: "Leg Day",
        description: "Quads, hamstrings, glutes, and calves workout",
        exercises: [squats, legPress, romanianDeadlift, lunges, legCurls, legExtensions, calfRaises, hipThrusts],
        estimatedDuration: 60,
        iconName: "figure.walk.circle.fill"
    )

    static let upperBody = WorkoutPlan(
        name: "Upper Body",
        description: "Complete upper body workout combining push and pull",
        exercises: [benchPress, barbellRows, overheadPress, latPulldown, inclineDumbbellPress, bicepCurls, tricepPushdown],
        estimatedDuration: 55,
        iconName: "figure.arms.open"
    )

    static let lowerBody = WorkoutPlan(
        name: "Lower Body",
        description: "Complete lower body workout for strength and size",
        exercises: [squats, romanianDeadlift, legPress, lunges, legCurls, calfRaises],
        estimatedDuration: 50,
        iconName: "figure.walk"
    )

    static let fullBody = WorkoutPlan(
        name: "Full Body",
        description: "Total body workout hitting all major muscle groups",
        exercises: [squats, benchPress, barbellRows, overheadPress, romanianDeadlift, pullUps, lunges, bicepCurls],
        estimatedDuration: 65,
        iconName: "figure.highintensity.intervaltraining"
    )

    static let allWorkouts: [WorkoutPlan] = [
        pushDay, pullDay, legDay, upperBody, lowerBody, fullBody
    ]
}
