import Foundation

struct WorkoutPlanGenerator {
    // MARK: - All Available Strength Exercises
    static let strengthExercises: [Exercise] = [
        // MARK: - Chest (Barbell/Machine)
        Exercise(name: "Bench Press", muscleGroups: ["Chest", "Triceps", "Shoulders"],
                 instructions: "Lie on a flat bench with feet firmly on the ground. Grip the bar slightly wider than shoulder-width. Lower the bar to your mid-chest, then press back up to full arm extension.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Bench Press"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Bench Press"),
                 defaultSets: 4, defaultReps: 8,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Bench Press"),
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Incline Barbell Press", muscleGroups: ["Upper Chest", "Shoulders", "Triceps"],
                 instructions: "Set bench to 30-45 degree incline. Grip bar slightly wider than shoulder-width. Lower to upper chest, then press up.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 4, defaultReps: 8,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Decline Bench Press", muscleGroups: ["Lower Chest", "Triceps"],
                 instructions: "Lie on decline bench with feet secured. Lower bar to lower chest, then press back up. Focus on squeezing chest at top.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Cable Crossover", muscleGroups: ["Chest"],
                 instructions: "Stand between cable machines with handles at high position. Step forward, bring handles together in front of chest with slight elbow bend.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Cable Crossover"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Machine Chest Press", muscleGroups: ["Chest", "Triceps", "Shoulders"],
                 instructions: "Sit with back flat against pad. Grip handles at chest level. Push forward until arms extended, then return with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Pec Deck Machine", muscleGroups: ["Chest"],
                 instructions: "Sit with back against pad, arms on padded levers. Bring arms together in front of chest, squeezing pecs. Return slowly.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Chest (Dumbbell)
        Exercise(name: "Dumbbell Bench Press", muscleGroups: ["Chest", "Triceps", "Shoulders"],
                 instructions: "Lie on flat bench with dumbbells at chest level. Press up until arms extended, then lower with control. Keep feet flat on floor.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 4, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Incline Dumbbell Press", muscleGroups: ["Upper Chest", "Shoulders", "Triceps"],
                 instructions: "Set bench to 30-45 degree incline. Hold dumbbells at shoulder level with palms facing forward. Press weights up until arms are extended.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Incline Dumbbell Press"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Incline Dumbbell Press"),
                 defaultSets: 3, defaultReps: 10,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Incline Dumbbell Press"),
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Decline Dumbbell Press", muscleGroups: ["Lower Chest", "Triceps"],
                 instructions: "Lie on decline bench with feet secured. Press dumbbells up from chest level, then lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Dumbbell Flyes", muscleGroups: ["Chest"],
                 instructions: "Lie on a flat bench with dumbbells above chest, palms facing each other. Lower weights out to sides with slight elbow bend, then squeeze back together.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Dumbbell Flyes"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Incline Dumbbell Flyes", muscleGroups: ["Upper Chest"],
                 instructions: "Set bench to 30-degree incline. Hold dumbbells above chest, lower out to sides with slight bend in elbows, then squeeze back up.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Dumbbell Pullover", muscleGroups: ["Chest", "Lats"],
                 instructions: "Lie across bench with only upper back supported. Hold dumbbell above chest, lower behind head with slight elbow bend, then pull back over chest.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),

        // MARK: - Chest (Bodyweight)
        Exercise(name: "Push-Ups", muscleGroups: ["Chest", "Triceps", "Shoulders"],
                 instructions: "Start in plank position with hands slightly wider than shoulders. Lower chest to ground, then push back up. Keep core tight throughout.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Push-Ups"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Push-Ups"),
                 defaultSets: 3, defaultReps: 15,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Push-Ups"),
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Incline Push-Ups", muscleGroups: ["Lower Chest", "Triceps", "Shoulders"],
                 instructions: "Place hands on elevated surface (bench, step). Perform push-up, lowering chest toward hands. Easier variation for beginners.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Decline Push-Ups", muscleGroups: ["Upper Chest", "Triceps", "Shoulders"],
                 instructions: "Place feet on elevated surface, hands on floor. Perform push-up, focusing on upper chest. More challenging variation.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Diamond Push-Ups", muscleGroups: ["Chest", "Triceps"],
                 instructions: "Form diamond shape with hands under chest (index fingers and thumbs touching). Perform push-up, focusing on triceps.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Wide Push-Ups", muscleGroups: ["Chest", "Shoulders"],
                 instructions: "Place hands wider than shoulder-width. Perform push-up, focusing on chest stretch at bottom. Keep core engaged.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Archer Push-Ups", muscleGroups: ["Chest", "Triceps", "Shoulders"],
                 instructions: "Start in wide push-up position. Lower toward one hand while extending the other arm. Alternate sides.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 8,
                 exerciseType: .compound, caloriesPerMinute: 8),

        // MARK: - Back (Barbell/Machine)
        Exercise(name: "Deadlift", muscleGroups: ["Back", "Hamstrings", "Glutes"],
                 instructions: "Stand with feet hip-width apart, bar over mid-foot. Hinge at hips and grip the bar. Keep back flat, drive through heels and extend hips and knees.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Deadlift"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Deadlift"),
                 defaultSets: 4, defaultReps: 6,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Deadlift"),
                 exerciseType: .compound, caloriesPerMinute: 9),
        Exercise(name: "Barbell Rows", muscleGroups: ["Back", "Biceps"],
                 instructions: "Bend at hips with slight knee bend, back flat. Pull bar to lower chest, squeezing shoulder blades together.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Barbell Rows"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Barbell Rows"),
                 defaultSets: 4, defaultReps: 8,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Barbell Rows"),
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Pendlay Rows", muscleGroups: ["Back", "Biceps"],
                 instructions: "Start with bar on floor. Bend over with back parallel to ground. Explosively row bar to lower chest, lower to floor, reset each rep.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 4, defaultReps: 6,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "T-Bar Row", muscleGroups: ["Back", "Biceps"],
                 instructions: "Straddle the T-bar or landmine. Grip handles, hinge at hips. Pull weight to chest, squeezing back. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 4, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Lat Pulldown", muscleGroups: ["Back", "Biceps"],
                 instructions: "Sit at the lat pulldown machine and grip the bar wider than shoulder-width. Pull the bar down to your upper chest while squeezing your lats.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Lat Pulldown"),
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Close-Grip Lat Pulldown", muscleGroups: ["Back", "Biceps"],
                 instructions: "Use V-bar or close-grip handle. Pull down to upper chest, focusing on squeezing lats. Keep elbows close to body.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Seated Cable Row", muscleGroups: ["Back", "Biceps"],
                 instructions: "Sit at cable row machine, feet on platform. Pull handle to lower chest, squeezing shoulder blades together. Return with control.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Seated Cable Row"),
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Face Pulls", muscleGroups: ["Rear Delts", "Upper Back"],
                 instructions: "Set cable at face height with rope attachment. Pull toward your face, separating the rope ends. Squeeze shoulder blades together.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Face Pulls"),
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Straight-Arm Pulldown", muscleGroups: ["Lats"],
                 instructions: "Stand facing cable machine with straight bar at high position. Keep arms straight, pull bar down to thighs, squeezing lats.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Machine Row", muscleGroups: ["Back", "Biceps"],
                 instructions: "Sit at row machine with chest against pad. Pull handles back, squeezing shoulder blades. Return with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),

        // MARK: - Back (Dumbbell)
        Exercise(name: "Dumbbell Rows", muscleGroups: ["Back", "Biceps"],
                 instructions: "Place one knee and hand on bench, other foot on floor. Pull dumbbell to hip, squeezing back at top. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Dumbbell Rows"),
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 6),
        Exercise(name: "Dumbbell Deadlift", muscleGroups: ["Back", "Hamstrings", "Glutes"],
                 instructions: "Stand with dumbbells at sides. Hinge at hips, lowering dumbbells along legs. Keep back flat, drive through heels to stand.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 4, defaultReps: 8,
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Chest-Supported Dumbbell Row", muscleGroups: ["Back", "Biceps"],
                 instructions: "Lie face down on incline bench. Let dumbbells hang, then row up to sides, squeezing shoulder blades. Great for isolating back.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Dumbbell Pullover", muscleGroups: ["Lats", "Chest"],
                 instructions: "Lie across bench, hold dumbbell above chest. Lower behind head with slight elbow bend, pull back over chest using lats.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Renegade Rows", muscleGroups: ["Back", "Core"],
                 instructions: "Start in push-up position holding dumbbells. Row one dumbbell to hip while stabilizing with other arm. Alternate sides.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Bent-Over Dumbbell Rows", muscleGroups: ["Back", "Biceps"],
                 instructions: "Bend at hips with dumbbells hanging. Row both dumbbells to hips simultaneously, squeezing back. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Dumbbell Shrugs", muscleGroups: ["Traps"],
                 instructions: "Stand holding dumbbells at sides. Shrug shoulders up toward ears, squeezing traps at top. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Back (Bodyweight)
        Exercise(name: "Pull-Ups", muscleGroups: ["Back", "Biceps"],
                 instructions: "Hang from a bar with palms facing away. Pull yourself up until chin clears the bar. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Pull-Ups"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Pull-Ups"),
                 defaultSets: 3, defaultReps: 8,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Pull-Ups"),
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Chin-Ups", muscleGroups: ["Back", "Biceps"],
                 instructions: "Hang from bar with palms facing you (underhand grip). Pull up until chin clears bar. Emphasizes biceps more than pull-ups.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 8,
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Neutral Grip Pull-Ups", muscleGroups: ["Back", "Biceps"],
                 instructions: "Use parallel handles with palms facing each other. Pull up until chin clears handles. Easier on shoulders than standard pull-ups.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 8,
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Inverted Rows", muscleGroups: ["Back", "Biceps"],
                 instructions: "Hang under bar or rings with feet on ground. Pull chest to bar, keeping body straight. Great pull-up alternative.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Scapular Pull-Ups", muscleGroups: ["Back", "Shoulders"],
                 instructions: "Hang from bar with arms straight. Retract shoulder blades to lift body slightly without bending arms. Great for activation.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Superman Hold", muscleGroups: ["Lower Back", "Glutes"],
                 instructions: "Lie face down, extend arms overhead. Lift arms, chest, and legs off ground simultaneously. Hold, then lower.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Reverse Snow Angels", muscleGroups: ["Upper Back", "Rear Delts"],
                 instructions: "Lie face down with arms at sides. Lift arms and sweep overhead like making snow angel. Squeeze upper back throughout.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 3),

        // MARK: - Shoulders (Barbell/Machine)
        Exercise(name: "Overhead Press", muscleGroups: ["Shoulders", "Triceps"],
                 instructions: "Stand with feet shoulder-width apart. Hold the barbell at shoulder height. Press the bar overhead until arms are fully extended.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Overhead Press"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Overhead Press"),
                 defaultSets: 3, defaultReps: 10,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Overhead Press"),
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Seated Barbell Press", muscleGroups: ["Shoulders", "Triceps"],
                 instructions: "Sit on bench with back support. Press barbell from shoulder height overhead. More stable than standing version.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Push Press", muscleGroups: ["Shoulders", "Triceps", "Legs"],
                 instructions: "Hold barbell at shoulders. Dip knees slightly, then explosively drive up while pressing bar overhead. Uses leg drive.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 4, defaultReps: 6,
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Machine Shoulder Press", muscleGroups: ["Shoulders", "Triceps"],
                 instructions: "Sit at machine with back against pad. Grip handles at shoulder level. Press up until arms extended, lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Cable Lateral Raises", muscleGroups: ["Shoulders"],
                 instructions: "Stand sideways to cable machine, handle at low position. Raise arm out to side to shoulder height. Great constant tension.",
                 imageName: "figure.arms.open",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Upright Rows", muscleGroups: ["Shoulders", "Traps"],
                 instructions: "Hold barbell with narrow grip. Pull bar up along body to chin level, elbows pointing out. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Barbell Shrugs", muscleGroups: ["Traps"],
                 instructions: "Hold barbell at thighs with overhand grip. Shrug shoulders up toward ears, squeezing traps. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Shoulders (Dumbbell)
        Exercise(name: "Dumbbell Shoulder Press", muscleGroups: ["Shoulders", "Triceps"],
                 instructions: "Sit or stand with dumbbells at shoulder height. Press up until arms extended. Lower to shoulders with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Arnold Press", muscleGroups: ["Shoulders", "Triceps"],
                 instructions: "Start with dumbbells at shoulder height, palms facing you. Rotate palms outward as you press overhead. Reverse on the way down.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Arnold Press"),
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Lateral Raises", muscleGroups: ["Shoulders"],
                 instructions: "Stand with dumbbells at your sides. Raise arms out to the sides until parallel with the ground. Lower with control.",
                 imageName: "figure.arms.open",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Lateral Raises"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Lateral Raises"),
                 defaultSets: 3, defaultReps: 15,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Lateral Raises"),
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Front Raises", muscleGroups: ["Shoulders"],
                 instructions: "Stand with dumbbells in front of thighs. Raise one or both arms straight in front to shoulder height. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Front Raises"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Reverse Flyes", muscleGroups: ["Rear Delts", "Upper Back"],
                 instructions: "Bend forward at hips with dumbbells hanging down. Raise arms out to sides, squeezing shoulder blades together.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Reverse Flyes"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Seated Bent-Over Rear Delt Raises", muscleGroups: ["Rear Delts"],
                 instructions: "Sit on bench, lean forward with chest near thighs. Raise dumbbells out to sides, squeezing rear delts.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Dumbbell Upright Rows", muscleGroups: ["Shoulders", "Traps"],
                 instructions: "Hold dumbbells in front of thighs. Pull up along body, elbows leading, to chin level. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Lu Raises", muscleGroups: ["Shoulders"],
                 instructions: "Hold light dumbbells. Raise arms to front at 45-degree angle with thumbs up. Great for front and side delt combination.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Shoulders (Bodyweight)
        Exercise(name: "Pike Push-Ups", muscleGroups: ["Shoulders", "Triceps"],
                 instructions: "Start in downward dog position with hips high. Bend elbows to lower head toward floor. Push back up. Shoulder-focused push-up.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Handstand Push-Ups", muscleGroups: ["Shoulders", "Triceps"],
                 instructions: "Kick up to handstand against wall. Bend elbows to lower head toward floor. Push back up. Advanced exercise.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 6,
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Wall Walks", muscleGroups: ["Shoulders", "Core"],
                 instructions: "Start in push-up position with feet at wall. Walk hands back while walking feet up wall. Walk back down. Full shoulder engagement.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 5,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Prone Y Raises", muscleGroups: ["Rear Delts", "Upper Back"],
                 instructions: "Lie face down with arms extended. Raise arms up in Y shape, squeezing shoulder blades. Great for shoulder health.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 3),
        Exercise(name: "Prone T Raises", muscleGroups: ["Rear Delts", "Upper Back"],
                 instructions: "Lie face down with arms out to sides. Raise arms up, squeezing shoulder blades together. Targets rear delts.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 3),

        // MARK: - Biceps (Barbell/Machine)
        Exercise(name: "Barbell Curls", muscleGroups: ["Biceps"],
                 instructions: "Stand with barbell at thighs, palms facing up. Curl bar to shoulders keeping elbows stationary. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "EZ Bar Curls", muscleGroups: ["Biceps"],
                 instructions: "Use EZ curl bar for wrist-friendly grip. Curl to shoulders, squeezing biceps. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Preacher Curls", muscleGroups: ["Biceps"],
                 instructions: "Sit at preacher bench with arms over pad. Curl weight up, squeezing biceps at top. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Preacher Curls"),
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Cable Curls", muscleGroups: ["Biceps"],
                 instructions: "Stand facing cable machine with bar at low position. Curl up, keeping elbows at sides. Great constant tension.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Machine Bicep Curls", muscleGroups: ["Biceps"],
                 instructions: "Sit at machine with arms on pad. Curl handles up, squeezing biceps at top. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Biceps (Dumbbell)
        Exercise(name: "Bicep Curls", muscleGroups: ["Biceps"],
                 instructions: "Stand with dumbbells at your sides, palms facing forward. Curl the weights up toward your shoulders, keeping elbows stationary.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Bicep Curls"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Bicep Curls"),
                 defaultSets: 3, defaultReps: 12,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Bicep Curls"),
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Hammer Curls", muscleGroups: ["Biceps", "Forearms"],
                 instructions: "Stand with dumbbells at your sides, palms facing each other. Curl the weights up while maintaining the neutral grip.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Hammer Curls"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Incline Dumbbell Curls", muscleGroups: ["Biceps"],
                 instructions: "Sit on incline bench with dumbbells hanging at sides. Curl weights up without moving upper arms. Squeeze at top.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Incline Dumbbell Curls"),
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Concentration Curls", muscleGroups: ["Biceps"],
                 instructions: "Sit with elbow braced against inner thigh. Curl dumbbell up, squeezing at top. Great for peak contraction.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Cross-Body Hammer Curls", muscleGroups: ["Biceps", "Forearms"],
                 instructions: "Curl dumbbell across body toward opposite shoulder with neutral grip. Alternate arms. Hits brachialis well.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Zottman Curls", muscleGroups: ["Biceps", "Forearms"],
                 instructions: "Curl up with palms facing up, rotate to palms down at top, lower with palms down. Great for forearms.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Spider Curls", muscleGroups: ["Biceps"],
                 instructions: "Lie chest-down on incline bench. Let arms hang straight, curl dumbbells up. Eliminates momentum.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Biceps (Bodyweight)
        Exercise(name: "Chin-Up Hold", muscleGroups: ["Biceps", "Back"],
                 instructions: "Pull up to chin-up position with underhand grip. Hold at top for time, squeezing biceps. Build isometric strength.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 20,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Bodyweight Bicep Curls", muscleGroups: ["Biceps"],
                 instructions: "Hang from bar with underhand grip. Curl body up by bending elbows, keeping body rigid. Advanced movement.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 8,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Towel Curls", muscleGroups: ["Biceps"],
                 instructions: "Loop towel under foot, hold ends. Curl up against resistance of your foot pressing down. Adjustable difficulty.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 3),

        // MARK: - Triceps (Barbell/Machine/Cable)
        Exercise(name: "Close-Grip Bench Press", muscleGroups: ["Triceps", "Chest"],
                 instructions: "Lie on bench, grip bar with hands shoulder-width apart. Lower to chest, press up. Tricep-focused pressing.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Skull Crushers", muscleGroups: ["Triceps"],
                 instructions: "Lie on bench with barbell or dumbbells above chest. Bend elbows to lower weight toward forehead. Extend arms back up.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Skull Crushers"),
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Tricep Pushdown", muscleGroups: ["Triceps"],
                 instructions: "Stand facing cable machine with straight or rope attachment. Keep elbows pinned to sides and push weight down until arms are extended.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Tricep Pushdown"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Tricep Pushdown"),
                 defaultSets: 3, defaultReps: 12,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Tricep Pushdown"),
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Rope Pushdown", muscleGroups: ["Triceps"],
                 instructions: "Use rope attachment on cable. Push down and spread rope apart at bottom for extra contraction. Keep elbows pinned.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Overhead Cable Extension", muscleGroups: ["Triceps"],
                 instructions: "Face away from cable, rope at low position. Extend arms overhead, keeping elbows by ears. Squeeze triceps at top.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Cable Kickbacks", muscleGroups: ["Triceps"],
                 instructions: "Hinge forward, upper arm parallel to floor. Extend forearm back until straight, squeeze tricep. Return with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Triceps (Dumbbell)
        Exercise(name: "Overhead Tricep Extension", muscleGroups: ["Triceps"],
                 instructions: "Hold dumbbell overhead with both hands. Lower weight behind head by bending elbows. Extend arms back up.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Overhead Tricep Extension"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Dumbbell Skull Crushers", muscleGroups: ["Triceps"],
                 instructions: "Lie on bench with dumbbells above chest. Lower weights toward temples by bending elbows. Extend back up.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Tricep Kickbacks", muscleGroups: ["Triceps"],
                 instructions: "Hinge forward with dumbbell, upper arm parallel to floor. Extend forearm back. Squeeze at full extension.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Single-Arm Overhead Extension", muscleGroups: ["Triceps"],
                 instructions: "Hold dumbbell overhead with one arm. Lower behind head, extend back up. Focus on stretch and contraction.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Tate Press", muscleGroups: ["Triceps"],
                 instructions: "Lie on bench, hold dumbbells above chest with elbows out. Lower weights to chest by bending elbows inward. Press back up.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Triceps (Bodyweight)
        Exercise(name: "Tricep Dips", muscleGroups: ["Triceps", "Chest", "Shoulders"],
                 instructions: "Grip parallel bars and lift yourself up. Lower your body by bending elbows until upper arms are parallel to ground. Push back up.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Tricep Dips"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Bench Dips", muscleGroups: ["Triceps"],
                 instructions: "Place hands on bench behind you, feet on floor. Lower body by bending elbows to 90 degrees. Push back up.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Close-Grip Push-Ups", muscleGroups: ["Triceps", "Chest"],
                 instructions: "Perform push-up with hands close together under chest. Keep elbows close to body. Tricep-focused push-up.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Bodyweight Tricep Extensions", muscleGroups: ["Triceps"],
                 instructions: "Place hands on bar or elevated surface. Lower forehead toward hands by bending elbows. Push back up using triceps.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),

        // MARK: - Legs/Quads (Barbell/Machine)
        Exercise(name: "Barbell Squats", muscleGroups: ["Quads", "Glutes", "Hamstrings"],
                 instructions: "Position bar on upper back. Stand with feet shoulder-width apart. Squat down until thighs are parallel to ground. Drive through heels to stand.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Barbell Squats"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Barbell Squats"),
                 defaultSets: 4, defaultReps: 8,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Barbell Squats"),
                 exerciseType: .compound, caloriesPerMinute: 9),
        Exercise(name: "Front Squats", muscleGroups: ["Quads", "Core"],
                 instructions: "Hold barbell at front of shoulders with clean grip or crossed arms. Squat keeping elbows high and chest up. Drive through heels.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 4, defaultReps: 8,
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Hack Squats", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Position shoulders under pads, feet on platform. Lower by bending knees, keeping back against pad. Press up through heels.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 4, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Leg Press", muscleGroups: ["Quads", "Glutes", "Hamstrings"],
                 instructions: "Sit in leg press machine with feet shoulder-width on platform. Lower weight by bending knees to 90 degrees. Press back up.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Leg Press"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Leg Press"),
                 defaultSets: 4, defaultReps: 10,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Leg Press"),
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Leg Extensions", muscleGroups: ["Quads"],
                 instructions: "Sit in leg extension machine with pad on lower shins. Extend legs until straight, squeezing quads at top.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Leg Extensions"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Smith Machine Squats", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Position bar on upper back in Smith machine. Feet slightly forward. Squat down and press up. More stable than free bar.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 4, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 7),

        // MARK: - Legs/Quads (Dumbbell)
        Exercise(name: "Goblet Squats", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Hold dumbbell or kettlebell at chest. Squat down keeping chest up and elbows inside knees. Drive through heels to stand.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Goblet Squats"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Dumbbell Lunges", muscleGroups: ["Quads", "Glutes", "Hamstrings"],
                 instructions: "Hold dumbbells at sides. Step forward into lunge, lowering until both knees at 90 degrees. Push back to standing.",
                 imageName: "figure.walk",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Walking Lunges", muscleGroups: ["Quads", "Glutes", "Hamstrings"],
                 instructions: "Step forward into a lunge, lowering until both knees are at 90 degrees. Push off front foot and step forward into next lunge.",
                 imageName: "figure.walk",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Walking Lunges"),
                 gifURL: ExerciseVideoLibrary.getGifURL(for: "Walking Lunges"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Bulgarian Split Squats", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Stand with rear foot elevated on bench. Lower into lunge until front thigh is parallel to ground. Push through front heel to stand.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Bulgarian Split Squats"),
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Dumbbell Step-Ups", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Hold dumbbells at sides, face bench or box. Step up with one foot, drive through heel to stand. Step down with control.",
                 imageName: "figure.stairs",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Reverse Lunges", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Hold dumbbells at sides. Step backward into lunge, lowering until both knees at 90 degrees. Return to standing.",
                 imageName: "figure.walk",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Dumbbell Sumo Squats", muscleGroups: ["Quads", "Glutes", "Inner Thighs"],
                 instructions: "Wide stance with toes pointed out. Hold dumbbell between legs. Squat down keeping knees over toes. Drive up through heels.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 6),

        // MARK: - Legs/Quads (Bodyweight)
        Exercise(name: "Bodyweight Squats", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Stand with feet shoulder-width apart. Squat down keeping chest up, weight in heels. Stand back up squeezing glutes.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 20,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Jump Squats", muscleGroups: ["Quads", "Glutes", "Calves"],
                 instructions: "Perform squat, then explode up into jump. Land softly and immediately go into next squat. Keep core tight.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .compound, caloriesPerMinute: 10),
        Exercise(name: "Pistol Squats", muscleGroups: ["Quads", "Glutes", "Core"],
                 instructions: "Stand on one leg, extend other leg forward. Squat down on standing leg as low as possible. Push back up. Advanced exercise.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 5,
                 exerciseType: .compound, caloriesPerMinute: 8),
        Exercise(name: "Split Squats", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Stand in split stance. Lower back knee toward ground while front thigh goes parallel. Push through front heel to stand.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Wall Sits", muscleGroups: ["Quads"],
                 instructions: "Lean back against wall, slide down until thighs parallel to ground. Hold position for time. Great isometric quad builder.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 45,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Sissy Squats", muscleGroups: ["Quads"],
                 instructions: "Hold support for balance. Rise on toes, lean back while bending knees forward. Lower and rise using quads only.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Skater Squats", muscleGroups: ["Quads", "Glutes"],
                 instructions: "Stand on one leg, other leg back. Lower into single-leg squat until back knee nearly touches ground. Stand back up.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 8,
                 exerciseType: .compound, caloriesPerMinute: 6),

        // MARK: - Hamstrings & Glutes (Barbell/Machine)
        Exercise(name: "Romanian Deadlift", muscleGroups: ["Hamstrings", "Glutes", "Lower Back"],
                 instructions: "Hold barbell with overhand grip. Keep legs slightly bent. Hinge at hips, lowering bar along legs until hamstring stretch. Drive hips forward.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Romanian Deadlift"),
                 defaultSets: 3, defaultReps: 10,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Romanian Deadlift"),
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Stiff-Leg Deadlift", muscleGroups: ["Hamstrings", "Glutes"],
                 instructions: "Like RDL but with straighter legs. Hinge at hips lowering bar toward floor. Feel deep hamstring stretch. Return to standing.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 7),
        Exercise(name: "Leg Curls", muscleGroups: ["Hamstrings"],
                 instructions: "Lie face down on leg curl machine with pad above heels. Curl weight up by bending knees, squeezing hamstrings at top.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Leg Curls"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Seated Leg Curls", muscleGroups: ["Hamstrings"],
                 instructions: "Sit in machine with pad behind ankles. Curl heels toward glutes, squeezing hamstrings. Return with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Good Mornings", muscleGroups: ["Hamstrings", "Lower Back", "Glutes"],
                 instructions: "Stand with barbell on upper back. Hinge at hips, pushing them back while keeping back flat. Return to standing.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Good Mornings"),
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Hip Thrusts", muscleGroups: ["Glutes", "Hamstrings"],
                 instructions: "Sit with upper back against bench, barbell over hips. Drive through heels and squeeze glutes to lift hips until body forms straight line.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Hip Thrusts"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Cable Pull-Through", muscleGroups: ["Glutes", "Hamstrings"],
                 instructions: "Face away from cable, rope between legs. Hinge at hips, then drive hips forward squeezing glutes. Great hip hinge practice.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 5),

        // MARK: - Hamstrings & Glutes (Dumbbell)
        Exercise(name: "Dumbbell Romanian Deadlift", muscleGroups: ["Hamstrings", "Glutes"],
                 instructions: "Hold dumbbells at thighs. Hinge at hips with slight knee bend, lowering weights along legs. Drive hips forward to stand.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 6),
        Exercise(name: "Single-Leg Dumbbell RDL", muscleGroups: ["Hamstrings", "Glutes", "Core"],
                 instructions: "Stand on one leg holding dumbbell. Hinge at hip, extending free leg behind for balance. Return to standing.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .compound, caloriesPerMinute: 5),
        Exercise(name: "Dumbbell Hip Thrusts", muscleGroups: ["Glutes", "Hamstrings"],
                 instructions: "Back against bench, dumbbell on hips. Drive through heels, squeeze glutes to lift hips. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .compound, caloriesPerMinute: 5),

        // MARK: - Hamstrings & Glutes (Bodyweight)
        Exercise(name: "Glute Bridges", muscleGroups: ["Glutes", "Hamstrings"],
                 instructions: "Lie on back with knees bent, feet flat on floor. Squeeze glutes to lift hips until body forms straight line. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Glute Bridges"),
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Single-Leg Glute Bridge", muscleGroups: ["Glutes", "Hamstrings"],
                 instructions: "Lie on back, one leg extended. Drive through planted foot to lift hips. Keep hips level. Switch sides.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Nordic Curls", muscleGroups: ["Hamstrings"],
                 instructions: "Kneel with feet anchored. Lower body forward as slowly as possible using hamstrings. Push up from floor if needed.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 6,
                 exerciseType: .strength, caloriesPerMinute: 6),
        Exercise(name: "Donkey Kicks", muscleGroups: ["Glutes"],
                 instructions: "Start on hands and knees. Keeping knee bent, lift one leg up, driving heel toward ceiling. Squeeze glute at top.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Fire Hydrants", muscleGroups: ["Glutes", "Hip Abductors"],
                 instructions: "Start on hands and knees. Keeping knee bent, lift leg out to side to hip height. Great for hip mobility and glutes.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Frog Pumps", muscleGroups: ["Glutes"],
                 instructions: "Lie on back with soles of feet together, knees out. Drive hips up squeezing glutes, lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 20,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Calves
        Exercise(name: "Calf Raises", muscleGroups: ["Calves"],
                 instructions: "Stand on edge of step with heels hanging off. Rise up onto toes as high as possible. Lower heels below step level for full stretch.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Calf Raises"),
                 defaultSets: 4, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Seated Calf Raises", muscleGroups: ["Calves"],
                 instructions: "Sit at seated calf raise machine with pad on knees. Rise up onto toes, squeezing calves at top. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Seated Calf Raises"),
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 3),
        Exercise(name: "Dumbbell Calf Raises", muscleGroups: ["Calves"],
                 instructions: "Hold dumbbells at sides, stand on step. Rise onto toes, squeezing calves. Lower below platform level.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Single-Leg Calf Raises", muscleGroups: ["Calves"],
                 instructions: "Stand on one leg on step. Rise onto toes, lower below platform. Use wall for balance if needed.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Core (Cable/Machine)
        Exercise(name: "Cable Crunches", muscleGroups: ["Core"],
                 instructions: "Kneel facing cable machine with rope attachment. Crunch down, bringing elbows toward knees while contracting abs.",
                 imageName: "figure.core.training",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Cable Crunches"),
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Cable Woodchops", muscleGroups: ["Core", "Obliques"],
                 instructions: "Set cable at high position. Pull diagonally across body to opposite hip, rotating torso. Great for rotational strength.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Hanging Leg Raises", muscleGroups: ["Core", "Hip Flexors"],
                 instructions: "Hang from pull-up bar. Raise legs until parallel to ground or higher, keeping them straight. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Hanging Leg Raises"),
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Hanging Knee Raises", muscleGroups: ["Core"],
                 instructions: "Hang from bar, raise bent knees to chest. Easier variation of leg raises. Lower with control.",
                 imageName: "figure.strengthtraining.traditional",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Ab Wheel Rollouts", muscleGroups: ["Core"],
                 instructions: "Kneel holding ab wheel. Roll forward extending body, keeping core tight. Roll back to start using abs.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .strength, caloriesPerMinute: 6),
        Exercise(name: "Pallof Press", muscleGroups: ["Core", "Obliques"],
                 instructions: "Stand sideways to cable. Hold handle at chest, press out in front. Resist rotation while holding. Great anti-rotation.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),

        // MARK: - Core (Dumbbell/Weighted)
        Exercise(name: "Russian Twists", muscleGroups: ["Core", "Obliques"],
                 instructions: "Sit with knees bent, lean back slightly. Hold weight at chest and rotate torso side to side, touching weight to ground each side.",
                 imageName: "figure.core.training",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Russian Twists"),
                 defaultSets: 3, defaultReps: 20,
                 exerciseType: .strength, caloriesPerMinute: 6),
        Exercise(name: "Weighted Sit-Ups", muscleGroups: ["Core"],
                 instructions: "Hold weight at chest. Perform sit-up bringing chest to knees. Lower with control. Increase difficulty with heavier weight.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Dumbbell Side Bends", muscleGroups: ["Obliques"],
                 instructions: "Hold dumbbell in one hand at side. Bend sideways toward weight, then contract oblique to return upright. Switch sides.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Farmer's Carry", muscleGroups: ["Core", "Grip", "Traps"],
                 instructions: "Hold heavy dumbbells at sides. Walk with tall posture, engaging core throughout. Great for functional strength.",
                 imageName: "figure.walk",
                 defaultSets: 3, defaultReps: 40,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Suitcase Carry", muscleGroups: ["Core", "Obliques"],
                 instructions: "Hold dumbbell in one hand only. Walk keeping torso upright, resisting lean. Great anti-lateral flexion exercise.",
                 imageName: "figure.walk",
                 defaultSets: 3, defaultReps: 30,
                 exerciseType: .strength, caloriesPerMinute: 5),

        // MARK: - Core (Bodyweight)
        Exercise(name: "Planks", muscleGroups: ["Core"],
                 instructions: "Start in forearm plank position with body in straight line. Hold position, engaging core and glutes. Don't let hips sag or pike.",
                 imageName: "figure.core.training",
                 videoURL: ExerciseVideoLibrary.getVideoURL(for: "Planks"),
                 defaultSets: 3, defaultReps: 60,
                 formTips: ExerciseVideoLibrary.getFormTips(for: "Planks"),
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Side Planks", muscleGroups: ["Core", "Obliques"],
                 instructions: "Lie on side, prop on forearm. Lift hips creating straight line from head to feet. Hold position engaging obliques.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 30,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Crunches", muscleGroups: ["Core"],
                 instructions: "Lie on back with knees bent. Curl upper body toward knees, lifting shoulders off ground. Lower with control.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 20,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Bicycle Crunches", muscleGroups: ["Core", "Obliques"],
                 instructions: "Lie on back, hands behind head. Bring opposite elbow to knee while extending other leg. Alternate in pedaling motion.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 20,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Leg Raises", muscleGroups: ["Core", "Hip Flexors"],
                 instructions: "Lie on back with legs straight. Raise legs to vertical, keeping lower back pressed down. Lower with control.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Reverse Crunches", muscleGroups: ["Core"],
                 instructions: "Lie on back, lift bent knees toward chest. Curl hips off ground using lower abs. Lower with control.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Dead Bug", muscleGroups: ["Core"],
                 instructions: "Lie on back with arms up, knees bent 90 degrees. Lower opposite arm and leg toward floor. Keep lower back pressed down.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "Bird Dogs", muscleGroups: ["Core", "Lower Back"],
                 instructions: "Start on hands and knees. Extend opposite arm and leg, keeping hips level. Hold briefly, return. Alternate sides.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 3),
        Exercise(name: "Hollow Body Hold", muscleGroups: ["Core"],
                 instructions: "Lie on back, press lower back down. Extend arms overhead and legs out, lifting shoulders and legs. Hold position.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 30,
                 exerciseType: .strength, caloriesPerMinute: 4),
        Exercise(name: "V-Ups", muscleGroups: ["Core"],
                 instructions: "Lie flat, arms overhead. Simultaneously raise legs and torso, reaching hands toward feet. Lower with control.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 12,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Flutter Kicks", muscleGroups: ["Core", "Hip Flexors"],
                 instructions: "Lie on back, hands under hips. Lift legs slightly, alternate kicking up and down in small motion. Keep lower back down.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 30,
                 exerciseType: .strength, caloriesPerMinute: 5),
        Exercise(name: "Toe Touches", muscleGroups: ["Core"],
                 instructions: "Lie on back with legs vertical. Reach up and touch toes, lifting shoulders off ground. Lower with control.",
                 imageName: "figure.core.training",
                 defaultSets: 3, defaultReps: 15,
                 exerciseType: .strength, caloriesPerMinute: 4),
    ]

    // MARK: - Cardio Exercises
    static let cardioExercisesList: [Exercise] = [
        Exercise(name: "Treadmill Running", muscleGroups: ["Cardio", "Legs"],
                 instructions: "Run at a steady pace on the treadmill. Start with a warm-up walk, then increase speed to a comfortable running pace. Maintain good posture.",
                 imageName: "figure.run",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Treadmill Running"],
                 defaultSets: 1, defaultReps: 20,
                 formTips: ExerciseVideoLibrary.cardioFormTips["Treadmill Running"] ?? [],
                 exerciseType: .cardio, caloriesPerMinute: 12),
        Exercise(name: "Stationary Bike", muscleGroups: ["Cardio", "Legs"],
                 instructions: "Pedal at a steady pace. Adjust resistance to challenge yourself while maintaining proper form. Keep your back straight.",
                 imageName: "figure.indoor.cycle",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Stationary Bike"],
                 defaultSets: 1, defaultReps: 20,
                 exerciseType: .cardio, caloriesPerMinute: 10),
        Exercise(name: "Rowing Machine", muscleGroups: ["Cardio", "Back", "Arms", "Legs"],
                 instructions: "Push with legs first, then pull with arms. Keep back straight and core engaged. Return arms first, then bend knees.",
                 imageName: "figure.rower",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Rowing Machine"],
                 defaultSets: 1, defaultReps: 15,
                 formTips: ExerciseVideoLibrary.cardioFormTips["Rowing Machine"] ?? [],
                 exerciseType: .cardio, caloriesPerMinute: 11),
        Exercise(name: "Jumping Jacks", muscleGroups: ["Cardio", "Full Body"],
                 instructions: "Start standing with feet together and arms at sides. Jump while spreading legs and raising arms overhead. Return to starting position.",
                 imageName: "figure.jumprope",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Jumping Jacks"],
                 gifURL: ExerciseVideoLibrary.gifURLs["Jumping Jacks"],
                 defaultSets: 3, defaultReps: 30,
                 exerciseType: .cardio, caloriesPerMinute: 10),
        Exercise(name: "Burpees", muscleGroups: ["Cardio", "Full Body"],
                 instructions: "Start standing, squat down and place hands on floor. Jump feet back to plank, do a push-up (optional), jump feet forward, then explode up with arms overhead.",
                 imageName: "figure.highintensity.intervaltraining",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Burpees"],
                 gifURL: ExerciseVideoLibrary.gifURLs["Burpees"],
                 defaultSets: 3, defaultReps: 10,
                 formTips: ExerciseVideoLibrary.cardioFormTips["Burpees"] ?? [],
                 exerciseType: .cardio, caloriesPerMinute: 14),
        Exercise(name: "Mountain Climbers", muscleGroups: ["Cardio", "Core", "Shoulders"],
                 instructions: "Start in high plank position. Drive knees toward chest alternately in a running motion. Keep hips level and core tight.",
                 imageName: "figure.highintensity.intervaltraining",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Mountain Climbers"],
                 gifURL: ExerciseVideoLibrary.gifURLs["Mountain Climbers"],
                 defaultSets: 3, defaultReps: 20,
                 formTips: ExerciseVideoLibrary.cardioFormTips["Mountain Climbers"] ?? [],
                 exerciseType: .cardio, caloriesPerMinute: 11),
        Exercise(name: "High Knees", muscleGroups: ["Cardio", "Legs", "Core"],
                 instructions: "Run in place, driving knees up toward chest as high as possible. Pump arms in opposition. Maintain quick pace.",
                 imageName: "figure.run",
                 videoURL: ExerciseVideoLibrary.cardioVideos["High Knees"],
                 gifURL: ExerciseVideoLibrary.gifURLs["High Knees"],
                 defaultSets: 3, defaultReps: 30,
                 exerciseType: .cardio, caloriesPerMinute: 10),
        Exercise(name: "Box Jumps", muscleGroups: ["Cardio", "Legs", "Glutes"],
                 instructions: "Stand facing a sturdy box or platform. Squat slightly, then explode up, landing softly on the box. Step down and repeat.",
                 imageName: "figure.jumprope",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Box Jumps"],
                 defaultSets: 3, defaultReps: 10,
                 exerciseType: .cardio, caloriesPerMinute: 12),
        Exercise(name: "Jump Rope", muscleGroups: ["Cardio", "Legs", "Shoulders"],
                 instructions: "Hold rope handles at hip level. Turn wrists to swing rope and jump just high enough to clear it. Land softly on balls of feet.",
                 imageName: "figure.jumprope",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Jump Rope"],
                 gifURL: ExerciseVideoLibrary.gifURLs["Jump Rope"],
                 defaultSets: 3, defaultReps: 60,
                 formTips: ExerciseVideoLibrary.cardioFormTips["Jump Rope"] ?? [],
                 exerciseType: .cardio, caloriesPerMinute: 13),
        Exercise(name: "Battle Ropes", muscleGroups: ["Cardio", "Arms", "Core"],
                 instructions: "Hold one end of rope in each hand. Create waves by alternating arms up and down. Keep core tight and knees slightly bent.",
                 imageName: "figure.highintensity.intervaltraining",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Battle Ropes"],
                 defaultSets: 3, defaultReps: 30,
                 exerciseType: .cardio, caloriesPerMinute: 12),
        Exercise(name: "Stair Climber", muscleGroups: ["Cardio", "Legs", "Glutes"],
                 instructions: "Step onto the machine and set your pace. Climb at a steady rate, engaging your glutes and quads. Keep upright posture.",
                 imageName: "figure.stairs",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Stair Climber"],
                 defaultSets: 1, defaultReps: 15,
                 exerciseType: .cardio, caloriesPerMinute: 9),
        Exercise(name: "Elliptical", muscleGroups: ["Cardio", "Full Body"],
                 instructions: "Step onto the machine and begin pedaling in a smooth motion. Use arms for full-body engagement. Adjust resistance as needed.",
                 imageName: "figure.elliptical",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Elliptical"],
                 defaultSets: 1, defaultReps: 20,
                 exerciseType: .cardio, caloriesPerMinute: 8),
        Exercise(name: "Kettlebell Swings", muscleGroups: ["Cardio", "Glutes", "Hamstrings", "Core"],
                 instructions: "Stand with feet shoulder-width apart, kettlebell between feet. Hinge at hips, swing kettlebell back, then drive hips forward to swing it to chest height.",
                 imageName: "figure.strengthtraining.functional",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Kettlebell Swings"],
                 defaultSets: 3, defaultReps: 15,
                 formTips: ExerciseVideoLibrary.cardioFormTips["Kettlebell Swings"] ?? [],
                 exerciseType: .cardio, caloriesPerMinute: 12),
        Exercise(name: "Sprint Intervals", muscleGroups: ["Cardio", "Legs"],
                 instructions: "Sprint at maximum effort for 20-30 seconds, then walk or jog slowly for 60-90 seconds. Repeat for desired rounds.",
                 imageName: "figure.run",
                 videoURL: ExerciseVideoLibrary.cardioVideos["Sprint Intervals"],
                 defaultSets: 6, defaultReps: 1,
                 exerciseType: .cardio, caloriesPerMinute: 15),
    ]

    // MARK: - Combined Exercise Library
    static let allExercises: [Exercise] = strengthExercises + cardioExercisesList

    // MARK: - Exercise Categories
    static let chestExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Chest") || $0.muscleGroups.contains("Upper Chest") }
    static let backExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Back") || $0.muscleGroups.contains("Upper Back") }
    static let shoulderExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Shoulders") || $0.muscleGroups.contains("Rear Delts") }
    static let bicepExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Biceps") }
    static let tricepExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Triceps") && !$0.muscleGroups.contains("Chest") }
    static let quadExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Quads") }
    static let hamstringExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Hamstrings") && !$0.muscleGroups.contains("Quads") }
    static let gluteExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Glutes") && !$0.muscleGroups.contains("Quads") }
    static let calfExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Calves") }
    static let coreExercises: [Exercise] = strengthExercises.filter { $0.muscleGroups.contains("Core") }
    static let cardioExercises: [Exercise] = cardioExercisesList

    // MARK: - Exercise Difficulty Classification
    // Exercises that require more technical skill or are higher risk
    static let advancedOnlyExercises: Set<String> = [
        "Deadlift", "Barbell Squats", "Overhead Press", "Barbell Rows",
        "Good Mornings", "Skull Crushers", "Pull-Ups", "Bulgarian Split Squats"
    ]

    // Beginner-friendly exercises (machines, simpler movements)
    static let beginnerFriendlyExercises: Set<String> = [
        "Push-Ups", "Lat Pulldown", "Leg Press", "Leg Extensions", "Leg Curls",
        "Seated Cable Row", "Cable Crossover", "Tricep Pushdown", "Bicep Curls",
        "Hammer Curls", "Lateral Raises", "Glute Bridges", "Planks", "Calf Raises",
        "Dumbbell Flyes", "Face Pulls", "Goblet Squats", "Walking Lunges"
    ]

    // Low-impact exercises suitable for older adults (55+)
    static let lowImpactExercises: Set<String> = [
        "Lat Pulldown", "Seated Cable Row", "Leg Press", "Leg Extensions",
        "Leg Curls", "Cable Crossover", "Tricep Pushdown", "Bicep Curls",
        "Face Pulls", "Glute Bridges", "Planks", "Seated Calf Raises",
        "Dumbbell Rows", "Incline Dumbbell Press", "Stationary Bike",
        "Elliptical", "Rowing Machine"
    ]

    // High-impact exercises to avoid for older adults or those with joint issues
    static let highImpactExercises: Set<String> = [
        "Burpees", "Box Jumps", "Jump Rope", "Sprint Intervals",
        "High Knees", "Jumping Jacks", "Mountain Climbers"
    ]

    // Exercises particularly beneficial for glute/lower body (often preferred by females)
    static let gluteFocusedExercises: Set<String> = [
        "Hip Thrusts", "Glute Bridges", "Romanian Deadlift", "Bulgarian Split Squats",
        "Walking Lunges", "Goblet Squats", "Leg Curls", "Cable Kickbacks"
    ]

    // Exercises typically preferred for upper body mass (often preferred by males)
    static let upperBodyMassExercises: Set<String> = [
        "Bench Press", "Incline Dumbbell Press", "Barbell Rows", "Pull-Ups",
        "Overhead Press", "Deadlift", "Bicep Curls", "Tricep Dips"
    ]

    // MARK: - Profile-Based Exercise Filtering
    static func getFilteredExercises(from exercises: [Exercise], profile: UserProfile) -> [Exercise] {
        let age = profile.age
        let experience = profile.experienceEnum

        var filtered = exercises

        // Age-based filtering
        if age < 18 {
            // Youth: Avoid heavy barbell compounds, focus on bodyweight and machines
            filtered = filtered.filter { !advancedOnlyExercises.contains($0.name) }
        } else if age >= 55 {
            // Older adults: Prioritize low-impact, joint-friendly exercises
            filtered = filtered.filter { !highImpactExercises.contains($0.name) }
            // Prioritize low-impact exercises
            filtered = filtered.sorted { exercise1, exercise2 in
                let isLowImpact1 = lowImpactExercises.contains(exercise1.name)
                let isLowImpact2 = lowImpactExercises.contains(exercise2.name)
                if isLowImpact1 != isLowImpact2 {
                    return isLowImpact1
                }
                return false
            }
        } else if age >= 45 {
            // Middle-aged: Be cautious with high-impact cardio
            filtered = filtered.filter { exercise in
                // Allow high-impact if it's strength training, filter out high-impact cardio
                if exercise.isCardio && highImpactExercises.contains(exercise.name) {
                    return false
                }
                return true
            }
        }

        // Experience-based filtering
        switch experience {
        case .beginner:
            // Beginners: Avoid advanced exercises
            filtered = filtered.filter { !advancedOnlyExercises.contains($0.name) }
            // Prioritize beginner-friendly exercises
            filtered = filtered.sorted { exercise1, exercise2 in
                let isBeginner1 = beginnerFriendlyExercises.contains(exercise1.name)
                let isBeginner2 = beginnerFriendlyExercises.contains(exercise2.name)
                if isBeginner1 != isBeginner2 {
                    return isBeginner1
                }
                return false
            }
        case .intermediate:
            // Intermediate: Full access with some prioritization
            break
        case .advanced:
            // Advanced: Prioritize compound movements
            filtered = filtered.sorted { exercise1, exercise2 in
                let isCompound1 = exercise1.exerciseType == .compound
                let isCompound2 = exercise2.exerciseType == .compound
                if isCompound1 != isCompound2 {
                    return isCompound1
                }
                return false
            }
        }

        return filtered
    }

    // MARK: - Profile-Based Exercise Category
    static func getCategoryExercises(category: [Exercise], profile: UserProfile) -> [Exercise] {
        return getFilteredExercises(from: category, profile: profile)
    }

    // MARK: - Generate Rationale Based on Profile
    static func generateProfileRationale(profile: UserProfile, exerciseType: String) -> String {
        let age = profile.age
        let gender = profile.genderEnum
        let goal = profile.goalEnum
        let experience = profile.experienceEnum

        var rationale = ""

        // Goal-based rationale
        switch goal {
        case .loseWeight:
            rationale = "This \(exerciseType) workout maximizes calorie burn with moderate weights and higher repetitions. "
        case .buildMuscle:
            rationale = "This \(exerciseType) workout targets muscle hypertrophy with moderate to heavy weights and 8-12 reps. "
        case .improveEndurance:
            rationale = "This \(exerciseType) workout builds muscular endurance with lighter weights and higher reps. "
        case .generalFitness:
            rationale = "This \(exerciseType) workout provides balanced training for overall fitness. "
        case .increaseStrength:
            rationale = "This \(exerciseType) workout emphasizes heavy compound lifts for maximum strength gains. "
        case .toneUp:
            rationale = "This \(exerciseType) workout uses moderate weights with higher reps for muscle definition. "
        }

        // Age-based rationale
        if age < 18 {
            rationale += "Exercises focus on proper form and bodyweight movements appropriate for your age. "
        } else if age >= 55 {
            rationale += "We've selected joint-friendly, low-impact exercises that are effective yet safe for your age group. "
        } else if age >= 45 {
            rationale += "The workout balances intensity with joint health considerations. "
        }

        // Experience-based rationale
        switch experience {
        case .beginner:
            rationale += "As a beginner, we've chosen exercises that are easier to learn with proper form, using machines and simpler movements to build your foundation."
        case .intermediate:
            rationale += "With your experience, we've included a mix of compound and isolation exercises to continue your progress."
        case .advanced:
            rationale += "We've prioritized compound movements and challenging exercises to match your advanced training level."
        }

        // Gender-based notes (optional, based on common preferences)
        if gender == .female && goal == .toneUp {
            rationale += " The selection includes exercises particularly effective for lower body and glute development."
        } else if gender == .male && (goal == .buildMuscle || goal == .increaseStrength) {
            rationale += " Emphasis on compound pressing and pulling movements for upper body development."
        }

        return rationale
    }

    // MARK: - Generate Plans Based on Frequency (Legacy)
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

    // MARK: - Generate Personalized Plans Based on User Profile
    static func generatePersonalizedPlans(profile: UserProfile, daysPerWeek: Int) -> [GeneratedWorkoutDay] {
        // Each day includes strength training + cardio finisher
        // No more cardio-only days - every day has weights + cardio
        return generateStrengthDaysWithCardio(count: daysPerWeek, profile: profile)
    }

    // MARK: - Profile-Aware Strength Day Generation
    private static func generateStrengthDaysForProfile(count: Int, profile: UserProfile) -> [GeneratedWorkoutDay] {
        let goal = profile.goalEnum

        // Get filtered exercise categories based on profile
        let filteredChest = getCategoryExercises(category: chestExercises, profile: profile)
        let filteredBack = getCategoryExercises(category: backExercises, profile: profile)
        let filteredShoulders = getCategoryExercises(category: shoulderExercises, profile: profile)
        let filteredBiceps = getCategoryExercises(category: bicepExercises, profile: profile)
        let filteredTriceps = getCategoryExercises(category: tricepExercises, profile: profile)
        let filteredQuads = getCategoryExercises(category: quadExercises, profile: profile)
        let filteredHamstrings = getCategoryExercises(category: hamstringExercises, profile: profile)
        let filteredGlutes = getCategoryExercises(category: gluteExercises, profile: profile)
        let filteredCalves = getCategoryExercises(category: calfExercises, profile: profile)
        let filteredCore = getCategoryExercises(category: coreExercises, profile: profile)

        switch count {
        case 0:
            return []
        case 1:
            return [
                GeneratedWorkoutDay(
                    name: "Full Body Strength",
                    description: "Complete strength workout targeting all major muscle groups",
                    exercises: adjustExercisesForGoal(selectExercisesFrom([
                        (filteredChest, 2),
                        (filteredBack, 2),
                        (filteredQuads, 2),
                        (filteredShoulders, 1),
                        (filteredCore, 1)
                    ]), goal: goal),
                    iconName: "figure.strengthtraining.traditional",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "full body strength")
                )
            ]
        case 2:
            return [
                GeneratedWorkoutDay(
                    name: "Upper Body",
                    description: "Chest, back, shoulders, and arms",
                    exercises: adjustExercisesForGoal(selectExercisesFrom([
                        (filteredChest, 2),
                        (filteredBack, 2),
                        (filteredShoulders, 2),
                        (filteredBiceps, 1),
                        (filteredTriceps, 1)
                    ]), goal: goal),
                    iconName: "figure.arms.open",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "upper body")
                ),
                GeneratedWorkoutDay(
                    name: "Lower Body",
                    description: "Quads, hamstrings, glutes, and calves",
                    exercises: adjustExercisesForGoal(selectExercisesFrom([
                        (filteredQuads, 3),
                        (filteredHamstrings, 2),
                        (filteredGlutes, 1),
                        (filteredCalves, 1),
                        (filteredCore, 1)
                    ]), goal: goal),
                    iconName: "figure.walk",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "lower body")
                )
            ]
        default:
            // 3+ days: Push/Pull/Legs split
            var plans: [GeneratedWorkoutDay] = []

            plans.append(GeneratedWorkoutDay(
                name: "Push",
                description: "Chest, shoulders, and triceps",
                exercises: adjustExercisesForGoal(selectExercisesFrom([
                    (filteredChest, 3),
                    (filteredShoulders, 2),
                    (filteredTriceps, 2)
                ]), goal: goal),
                iconName: "arrow.up.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "push muscles")
            ))

            plans.append(GeneratedWorkoutDay(
                name: "Pull",
                description: "Back and biceps",
                exercises: adjustExercisesForGoal(selectExercisesFrom([
                    (filteredBack, 4),
                    (filteredBiceps, 2),
                    (filteredShoulders.filter { $0.muscleGroups.contains("Rear Delts") }, 1)
                ]), goal: goal),
                iconName: "arrow.down.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "pull muscles")
            ))

            plans.append(GeneratedWorkoutDay(
                name: "Legs",
                description: "Quads, hamstrings, glutes, and calves",
                exercises: adjustExercisesForGoal(selectExercisesFrom([
                    (filteredQuads, 3),
                    (filteredHamstrings, 2),
                    (filteredGlutes, 1),
                    (filteredCalves, 1)
                ]), goal: goal),
                iconName: "figure.walk.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "leg muscles")
            ))

            // Add additional days if needed
            if count >= 4 {
                plans.append(GeneratedWorkoutDay(
                    name: "Upper Hypertrophy",
                    description: "Upper body volume focus",
                    exercises: adjustExercisesForGoal(selectExercisesFrom([
                        (filteredChest, 2),
                        (filteredBack, 2),
                        (filteredShoulders, 2),
                        (filteredBiceps, 1),
                        (filteredTriceps, 1)
                    ]), goal: goal),
                    iconName: "figure.arms.open",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "upper body volume")
                ))
            }

            if count >= 5 {
                plans.append(GeneratedWorkoutDay(
                    name: "Lower Hypertrophy",
                    description: "Lower body volume focus",
                    exercises: adjustExercisesForGoal(selectExercisesFrom([
                        (filteredQuads, 2),
                        (filteredHamstrings, 2),
                        (filteredGlutes, 2),
                        (filteredCalves, 1),
                        (filteredCore, 1)
                    ]), goal: goal),
                    iconName: "figure.walk",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "lower body volume")
                ))
            }

            return plans
        }
    }

    // MARK: - Generate Strength Days with Cardio Finisher
    private static func generateStrengthDaysWithCardio(count: Int, profile: UserProfile) -> [GeneratedWorkoutDay] {
        let goal = profile.goalEnum
        let duration = profile.workoutDurationEnum
        let split = profile.workoutSplitEnum
        let frequency = profile.muscleFrequencyEnum
        let exerciseCount = duration.exerciseCount
        let cardioMinutes = duration.cardioMinutes

        // Get filtered exercise categories based on profile
        let filteredChest = getCategoryExercises(category: chestExercises, profile: profile)
        let filteredBack = getCategoryExercises(category: backExercises, profile: profile)
        let filteredShoulders = getCategoryExercises(category: shoulderExercises, profile: profile)
        let filteredBiceps = getCategoryExercises(category: bicepExercises, profile: profile)
        let filteredTriceps = getCategoryExercises(category: tricepExercises, profile: profile)
        let filteredQuads = getCategoryExercises(category: quadExercises, profile: profile)
        let filteredHamstrings = getCategoryExercises(category: hamstringExercises, profile: profile)
        let filteredGlutes = getCategoryExercises(category: gluteExercises, profile: profile)
        let filteredCalves = getCategoryExercises(category: calfExercises, profile: profile)
        let filteredCore = getCategoryExercises(category: coreExercises, profile: profile)
        let filteredCardio = getCategoryExercises(category: cardioExercisesList, profile: profile)

        // Helper to create cardio finisher based on profile
        func createCardioFinisher() -> [Exercise] {
            let age = profile.age
            var selectedCardio: [Exercise]

            // For older adults, prefer low-impact cardio
            if age >= 55 {
                let lowImpact = filteredCardio.filter { lowImpactExercises.contains($0.name) }
                selectedCardio = Array(lowImpact.shuffled().prefix(2))
            } else {
                // Mix of cardio based on goal
                switch goal {
                case .loseWeight, .toneUp:
                    // Higher intensity cardio
                    let hiitOptions = filteredCardio.filter { ["Burpees", "Mountain Climbers", "High Knees", "Jump Rope", "Kettlebell Swings"].contains($0.name) }
                    selectedCardio = Array(hiitOptions.shuffled().prefix(2))
                case .buildMuscle, .increaseStrength:
                    // Lower intensity to preserve energy
                    let lightOptions = filteredCardio.filter { ["Stationary Bike", "Rowing Machine", "Treadmill Running"].contains($0.name) }
                    selectedCardio = Array(lightOptions.shuffled().prefix(1))
                case .improveEndurance:
                    // Steady state cardio
                    let enduranceOptions = filteredCardio.filter { ["Treadmill Running", "Stationary Bike", "Rowing Machine", "Elliptical"].contains($0.name) }
                    selectedCardio = Array(enduranceOptions.shuffled().prefix(2))
                case .generalFitness:
                    // Mixed cardio
                    selectedCardio = Array(filteredCardio.shuffled().prefix(2))
                }
            }

            // Adjust cardio duration based on profile settings
            return selectedCardio.map { exercise in
                Exercise(
                    id: UUID(),
                    name: exercise.name,
                    muscleGroups: exercise.muscleGroups,
                    instructions: exercise.instructions,
                    imageName: exercise.imageName,
                    videoURL: exercise.videoURL,
                    gifURL: exercise.gifURL,
                    defaultSets: 1,
                    defaultReps: cardioMinutes / max(1, selectedCardio.count),  // Split cardio time
                    formTips: exercise.formTips,
                    exerciseType: .cardio,
                    caloriesPerMinute: exercise.caloriesPerMinute
                )
            }
        }

        // Helper to scale exercises based on duration
        func scaleExercises(_ exercises: [Exercise], targetCount: Int) -> [Exercise] {
            let adjusted = adjustExercisesForGoal(exercises, goal: goal)
            if adjusted.count <= targetCount {
                return adjusted
            }
            return Array(adjusted.prefix(targetCount))
        }

        // Generate plans based on user's preferred split type
        var plans: [GeneratedWorkoutDay] = []

        switch split {
        case .fullBody:
            // Full body workouts - each session hits upper and lower body
            // Repeat the full body workout to hit frequency target
            let sessionsNeeded = min(count, frequency.rawValue * 2)  // Full body hits everything each time

            for i in 0..<sessionsNeeded {
                let variant = i % 2  // Alternate between two full body variants
                let strengthExercises: [Exercise]

                if variant == 0 {
                    strengthExercises = selectExercisesFrom([
                        (filteredChest, 1),
                        (filteredBack, 1),
                        (filteredQuads, 1),
                        (filteredShoulders, 1),
                        (filteredHamstrings, 1),
                        (filteredBiceps, 1),
                        (filteredCore, 1)
                    ])
                } else {
                    strengthExercises = selectExercisesFrom([
                        (filteredChest.shuffled(), 1),
                        (filteredBack.shuffled(), 1),
                        (filteredGlutes, 1),
                        (filteredShoulders.shuffled(), 1),
                        (filteredQuads.shuffled(), 1),
                        (filteredTriceps, 1),
                        (filteredCore.shuffled(), 1)
                    ])
                }

                plans.append(GeneratedWorkoutDay(
                    name: sessionsNeeded > 1 ? "Full Body \(["A", "B", "C", "D", "E", "F"][i % 6])" : "Full Body",
                    description: "Complete workout targeting all major muscle groups",
                    exercises: scaleExercises(strengthExercises, targetCount: exerciseCount) + createCardioFinisher(),
                    iconName: "figure.strengthtraining.traditional",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "full body") + " Each session trains both upper and lower body. Includes \(cardioMinutes) minutes of cardio finisher."
                ))
            }

            // If user wants more days, add additional full body sessions
            if count > sessionsNeeded {
                for i in sessionsNeeded..<count {
                    let strengthExercises = selectExercisesFrom([
                        (filteredChest.shuffled(), 1),
                        (filteredBack.shuffled(), 1),
                        (filteredQuads.shuffled(), 1),
                        (filteredGlutes.shuffled(), 1),
                        (filteredShoulders.shuffled(), 1),
                        (filteredCore.shuffled(), 1)
                    ])

                    plans.append(GeneratedWorkoutDay(
                        name: "Full Body \(["A", "B", "C", "D", "E", "F"][i % 6])",
                        description: "Additional full body session for extra volume",
                        exercises: scaleExercises(strengthExercises, targetCount: exerciseCount) + createCardioFinisher(),
                        iconName: "figure.strengthtraining.traditional",
                        rationale: generateProfileRationale(profile: profile, exerciseType: "full body") + " Includes \(cardioMinutes) minutes of cardio finisher."
                    ))
                }
            }

        case .upperLower:
            // Upper/Lower split - alternate between upper and lower days
            // For 2x frequency: need 2 upper + 2 lower = 4 days ideal
            let upperDays = min((count + 1) / 2, frequency.rawValue)
            let lowerDays = min(count / 2, frequency.rawValue)

            // Generate upper body days
            for i in 0..<upperDays {
                let upperExercises = selectExercisesFrom([
                    (i == 0 ? filteredChest : filteredChest.shuffled(), 2),
                    (i == 0 ? filteredBack : filteredBack.shuffled(), 2),
                    (i == 0 ? filteredShoulders : filteredShoulders.shuffled(), 1),
                    (i == 0 ? filteredBiceps : filteredBiceps.shuffled(), 1),
                    (i == 0 ? filteredTriceps : filteredTriceps.shuffled(), 1)
                ])

                plans.append(GeneratedWorkoutDay(
                    name: upperDays > 1 ? "Upper Body \(["A", "B", "C"][i % 3])" : "Upper Body",
                    description: "Chest, back, shoulders, and arms",
                    exercises: scaleExercises(upperExercises, targetCount: exerciseCount) + createCardioFinisher(),
                    iconName: "figure.arms.open",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "upper body") + " Includes \(cardioMinutes) minutes of cardio finisher."
                ))
            }

            // Generate lower body days
            for i in 0..<lowerDays {
                let lowerExercises = selectExercisesFrom([
                    (i == 0 ? filteredQuads : filteredQuads.shuffled(), 2),
                    (i == 0 ? filteredHamstrings : filteredHamstrings.shuffled(), 2),
                    (i == 0 ? filteredGlutes : filteredGlutes.shuffled(), 1),
                    (i == 0 ? filteredCalves : filteredCalves.shuffled(), 1),
                    (i == 0 ? filteredCore : filteredCore.shuffled(), 1)
                ])

                plans.append(GeneratedWorkoutDay(
                    name: lowerDays > 1 ? "Lower Body \(["A", "B", "C"][i % 3])" : "Lower Body",
                    description: "Quads, hamstrings, glutes, and core",
                    exercises: scaleExercises(lowerExercises, targetCount: exerciseCount) + createCardioFinisher(),
                    iconName: "figure.walk.circle.fill",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "lower body") + " Includes \(cardioMinutes) minutes of cardio finisher."
                ))
            }

            // Interleave upper and lower days
            plans = interleaveUpperLower(plans)

        case .pushPullLegs:
            // Push/Pull/Legs split
            // For 2x frequency: need 2 of each = 6 days ideal
            let cyclesNeeded = max(1, frequency.rawValue)

            for cycle in 0..<cyclesNeeded {
                if plans.count < count {
                    // Push day
                    let pushExercises = selectExercisesFrom([
                        (cycle == 0 ? filteredChest : filteredChest.shuffled(), 2),
                        (cycle == 0 ? filteredShoulders : filteredShoulders.shuffled(), 2),
                        (cycle == 0 ? filteredTriceps : filteredTriceps.shuffled(), 2)
                    ])

                    plans.append(GeneratedWorkoutDay(
                        name: cyclesNeeded > 1 ? "Push \(["A", "B", "C"][cycle % 3])" : "Push",
                        description: "Chest, shoulders, and triceps",
                        exercises: scaleExercises(pushExercises, targetCount: exerciseCount) + createCardioFinisher(),
                        iconName: "arrow.up.circle.fill",
                        rationale: generateProfileRationale(profile: profile, exerciseType: "push muscles") + " Includes \(cardioMinutes) minutes of cardio finisher."
                    ))
                }

                if plans.count < count {
                    // Pull day
                    let pullExercises = selectExercisesFrom([
                        (cycle == 0 ? filteredBack : filteredBack.shuffled(), 3),
                        (cycle == 0 ? filteredBiceps : filteredBiceps.shuffled(), 2),
                        (filteredShoulders.filter { $0.muscleGroups.contains("Rear Delts") }, 1)
                    ])

                    plans.append(GeneratedWorkoutDay(
                        name: cyclesNeeded > 1 ? "Pull \(["A", "B", "C"][cycle % 3])" : "Pull",
                        description: "Back and biceps",
                        exercises: scaleExercises(pullExercises, targetCount: exerciseCount) + createCardioFinisher(),
                        iconName: "arrow.down.circle.fill",
                        rationale: generateProfileRationale(profile: profile, exerciseType: "pull muscles") + " Includes \(cardioMinutes) minutes of cardio finisher."
                    ))
                }

                if plans.count < count {
                    // Legs day
                    let legExercises = selectExercisesFrom([
                        (cycle == 0 ? filteredQuads : filteredQuads.shuffled(), 2),
                        (cycle == 0 ? filteredHamstrings : filteredHamstrings.shuffled(), 2),
                        (cycle == 0 ? filteredGlutes : filteredGlutes.shuffled(), 1),
                        (cycle == 0 ? filteredCalves : filteredCalves.shuffled(), 1),
                        (cycle == 0 ? filteredCore : filteredCore.shuffled(), 1)
                    ])

                    plans.append(GeneratedWorkoutDay(
                        name: cyclesNeeded > 1 ? "Legs \(["A", "B", "C"][cycle % 3])" : "Legs",
                        description: "Quads, hamstrings, glutes, and core",
                        exercises: scaleExercises(legExercises, targetCount: exerciseCount) + createCardioFinisher(),
                        iconName: "figure.walk.circle.fill",
                        rationale: generateProfileRationale(profile: profile, exerciseType: "leg muscles") + " Includes \(cardioMinutes) minutes of cardio finisher."
                    ))
                }
            }
        }

        return plans
    }

    // Helper to interleave upper and lower body days
    private static func interleaveUpperLower(_ plans: [GeneratedWorkoutDay]) -> [GeneratedWorkoutDay] {
        let upperDays = plans.filter { $0.name.contains("Upper") }
        let lowerDays = plans.filter { $0.name.contains("Lower") }

        var interleaved: [GeneratedWorkoutDay] = []
        let maxCount = max(upperDays.count, lowerDays.count)

        for i in 0..<maxCount {
            if i < upperDays.count {
                interleaved.append(upperDays[i])
            }
            if i < lowerDays.count {
                interleaved.append(lowerDays[i])
            }
        }

        return interleaved
    }

    // Legacy function - kept for compatibility, now redirects to split-based generation
    private static func generateStrengthDaysWithCardioLegacy(count: Int, profile: UserProfile) -> [GeneratedWorkoutDay] {
        let goal = profile.goalEnum
        let duration = profile.workoutDurationEnum
        let exerciseCount = duration.exerciseCount
        let cardioMinutes = duration.cardioMinutes

        // Get filtered exercise categories based on profile
        let filteredChest = getCategoryExercises(category: chestExercises, profile: profile)
        let filteredBack = getCategoryExercises(category: backExercises, profile: profile)
        let filteredShoulders = getCategoryExercises(category: shoulderExercises, profile: profile)
        let filteredBiceps = getCategoryExercises(category: bicepExercises, profile: profile)
        let filteredTriceps = getCategoryExercises(category: tricepExercises, profile: profile)
        let filteredQuads = getCategoryExercises(category: quadExercises, profile: profile)
        let filteredHamstrings = getCategoryExercises(category: hamstringExercises, profile: profile)
        let filteredGlutes = getCategoryExercises(category: gluteExercises, profile: profile)
        let filteredCalves = getCategoryExercises(category: calfExercises, profile: profile)
        let filteredCore = getCategoryExercises(category: coreExercises, profile: profile)
        let filteredCardio = getCategoryExercises(category: cardioExercisesList, profile: profile)

        // Helper to create cardio finisher based on profile
        func createCardioFinisher() -> [Exercise] {
            let age = profile.age
            var selectedCardio: [Exercise]

            if age >= 55 {
                let lowImpact = filteredCardio.filter { lowImpactExercises.contains($0.name) }
                selectedCardio = Array(lowImpact.shuffled().prefix(2))
            } else {
                switch goal {
                case .loseWeight, .toneUp:
                    let hiitOptions = filteredCardio.filter { ["Burpees", "Mountain Climbers", "High Knees", "Jump Rope", "Kettlebell Swings"].contains($0.name) }
                    selectedCardio = Array(hiitOptions.shuffled().prefix(2))
                case .buildMuscle, .increaseStrength:
                    let lightOptions = filteredCardio.filter { ["Stationary Bike", "Rowing Machine", "Treadmill Running"].contains($0.name) }
                    selectedCardio = Array(lightOptions.shuffled().prefix(1))
                case .improveEndurance:
                    let enduranceOptions = filteredCardio.filter { ["Treadmill Running", "Stationary Bike", "Rowing Machine", "Elliptical"].contains($0.name) }
                    selectedCardio = Array(enduranceOptions.shuffled().prefix(2))
                case .generalFitness:
                    selectedCardio = Array(filteredCardio.shuffled().prefix(2))
                }
            }

            return selectedCardio.map { exercise in
                Exercise(
                    id: UUID(),
                    name: exercise.name,
                    muscleGroups: exercise.muscleGroups,
                    instructions: exercise.instructions,
                    imageName: exercise.imageName,
                    videoURL: exercise.videoURL,
                    gifURL: exercise.gifURL,
                    defaultSets: 1,
                    defaultReps: cardioMinutes / max(1, selectedCardio.count),
                    formTips: exercise.formTips,
                    exerciseType: .cardio,
                    caloriesPerMinute: exercise.caloriesPerMinute
                )
            }
        }

        func scaleExercises(_ exercises: [Exercise], targetCount: Int) -> [Exercise] {
            let adjusted = adjustExercisesForGoal(exercises, goal: goal)
            if adjusted.count <= targetCount {
                return adjusted
            }
            return Array(adjusted.prefix(targetCount))
        }

        var plans: [GeneratedWorkoutDay] = []

        switch count {
        case 0:
            return []

        case 1:
            let strengthExercises = selectExercisesFrom([
                (filteredChest, 1),
                (filteredBack, 1),
                (filteredQuads, 1),
                (filteredShoulders, 1),
                (filteredCore, 1)
            ])
            let scaledStrength = scaleExercises(strengthExercises, targetCount: exerciseCount)
            let cardioFinisher = createCardioFinisher()

            plans.append(GeneratedWorkoutDay(
                name: "Full Body + Cardio",
                description: "Complete workout with strength and cardio",
                exercises: scaledStrength + cardioFinisher,
                iconName: "figure.strengthtraining.traditional",
                rationale: generateProfileRationale(profile: profile, exerciseType: "full body") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

        case 2:
            // Upper/Lower split + cardio each day
            let upperExercises = selectExercisesFrom([
                (filteredChest, 2),
                (filteredBack, 2),
                (filteredShoulders, 1),
                (filteredBiceps, 1),
                (filteredTriceps, 1)
            ])
            let lowerExercises = selectExercisesFrom([
                (filteredQuads, 2),
                (filteredHamstrings, 2),
                (filteredGlutes, 1),
                (filteredCalves, 1),
                (filteredCore, 1)
            ])

            plans.append(GeneratedWorkoutDay(
                name: "Upper Body + Cardio",
                description: "Chest, back, shoulders, arms with cardio finisher",
                exercises: scaleExercises(upperExercises, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "figure.arms.open",
                rationale: generateProfileRationale(profile: profile, exerciseType: "upper body") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

            plans.append(GeneratedWorkoutDay(
                name: "Lower Body + Cardio",
                description: "Legs and core with cardio finisher",
                exercises: scaleExercises(lowerExercises, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "figure.walk.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "lower body") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

        case 3:
            // Push/Pull/Legs + cardio each day
            let pushExercises = selectExercisesFrom([
                (filteredChest, 2),
                (filteredShoulders, 2),
                (filteredTriceps, 2)
            ])
            let pullExercises = selectExercisesFrom([
                (filteredBack, 3),
                (filteredBiceps, 2),
                (filteredShoulders.filter { $0.muscleGroups.contains("Rear Delts") }, 1)
            ])
            let legExercises = selectExercisesFrom([
                (filteredQuads, 2),
                (filteredHamstrings, 2),
                (filteredGlutes, 1),
                (filteredCalves, 1),
                (filteredCore, 1)
            ])

            plans.append(GeneratedWorkoutDay(
                name: "Push + Cardio",
                description: "Chest, shoulders, triceps with cardio finisher",
                exercises: scaleExercises(pushExercises, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "arrow.up.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "push muscles") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

            plans.append(GeneratedWorkoutDay(
                name: "Pull + Cardio",
                description: "Back and biceps with cardio finisher",
                exercises: scaleExercises(pullExercises, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "arrow.down.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "pull muscles") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

            plans.append(GeneratedWorkoutDay(
                name: "Legs + Cardio",
                description: "Quads, hamstrings, glutes with cardio finisher",
                exercises: scaleExercises(legExercises, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "figure.walk.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "leg muscles") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

        case 4:
            // Upper/Lower x2 + cardio each day
            let upperExercises1 = selectExercisesFrom([
                (filteredChest, 2),
                (filteredBack, 2),
                (filteredShoulders, 1),
                (filteredBiceps, 1),
                (filteredTriceps, 1)
            ])
            let lowerExercises1 = selectExercisesFrom([
                (filteredQuads, 2),
                (filteredHamstrings, 2),
                (filteredGlutes, 1),
                (filteredCalves, 1)
            ])

            plans.append(GeneratedWorkoutDay(
                name: "Upper Body A + Cardio",
                description: "Strength-focused upper body with cardio finisher",
                exercises: scaleExercises(upperExercises1, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "figure.arms.open",
                rationale: generateProfileRationale(profile: profile, exerciseType: "upper body strength") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

            plans.append(GeneratedWorkoutDay(
                name: "Lower Body A + Cardio",
                description: "Strength-focused lower body with cardio finisher",
                exercises: scaleExercises(lowerExercises1, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "figure.walk.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "lower body strength") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

            // Shuffle for variety on second round
            let upperExercises2 = selectExercisesFrom([
                (filteredChest.shuffled(), 2),
                (filteredBack.shuffled(), 2),
                (filteredShoulders.shuffled(), 1),
                (filteredBiceps.shuffled(), 1),
                (filteredTriceps.shuffled(), 1)
            ])
            let lowerExercises2 = selectExercisesFrom([
                (filteredQuads.shuffled(), 2),
                (filteredHamstrings.shuffled(), 2),
                (filteredGlutes.shuffled(), 1),
                (filteredCore, 1)
            ])

            plans.append(GeneratedWorkoutDay(
                name: "Upper Body B + Cardio",
                description: "Volume-focused upper body with cardio finisher",
                exercises: scaleExercises(upperExercises2, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "figure.arms.open",
                rationale: generateProfileRationale(profile: profile, exerciseType: "upper body volume") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

            plans.append(GeneratedWorkoutDay(
                name: "Lower Body B + Cardio",
                description: "Volume-focused lower body with cardio finisher",
                exercises: scaleExercises(lowerExercises2, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "figure.walk",
                rationale: generateProfileRationale(profile: profile, exerciseType: "lower body volume") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

        default:
            // 5+ days: PPL + Upper/Lower
            let pushExercises = selectExercisesFrom([
                (filteredChest, 2),
                (filteredShoulders, 2),
                (filteredTriceps, 2)
            ])
            let pullExercises = selectExercisesFrom([
                (filteredBack, 3),
                (filteredBiceps, 2)
            ])
            let legExercises = selectExercisesFrom([
                (filteredQuads, 2),
                (filteredHamstrings, 2),
                (filteredGlutes, 1),
                (filteredCalves, 1)
            ])

            plans.append(GeneratedWorkoutDay(
                name: "Push + Cardio",
                description: "Chest, shoulders, triceps with cardio finisher",
                exercises: scaleExercises(pushExercises, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "arrow.up.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "push muscles") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

            plans.append(GeneratedWorkoutDay(
                name: "Pull + Cardio",
                description: "Back and biceps with cardio finisher",
                exercises: scaleExercises(pullExercises, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "arrow.down.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "pull muscles") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

            plans.append(GeneratedWorkoutDay(
                name: "Legs + Cardio",
                description: "Full leg workout with cardio finisher",
                exercises: scaleExercises(legExercises, targetCount: exerciseCount) + createCardioFinisher(),
                iconName: "figure.walk.circle.fill",
                rationale: generateProfileRationale(profile: profile, exerciseType: "leg muscles") + " Includes \(cardioMinutes) minutes of cardio finisher."
            ))

            if count >= 4 {
                let upperHypertrophy = selectExercisesFrom([
                    (filteredChest.shuffled(), 2),
                    (filteredBack.shuffled(), 2),
                    (filteredShoulders.shuffled(), 2),
                    (filteredBiceps.shuffled(), 1),
                    (filteredTriceps.shuffled(), 1)
                ])
                plans.append(GeneratedWorkoutDay(
                    name: "Upper Hypertrophy + Cardio",
                    description: "Upper body volume with cardio finisher",
                    exercises: scaleExercises(upperHypertrophy, targetCount: exerciseCount) + createCardioFinisher(),
                    iconName: "figure.arms.open",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "upper body hypertrophy") + " Includes \(cardioMinutes) minutes of cardio finisher."
                ))
            }

            if count >= 5 {
                let lowerHypertrophy = selectExercisesFrom([
                    (filteredQuads.shuffled(), 2),
                    (filteredHamstrings.shuffled(), 2),
                    (filteredGlutes.shuffled(), 2),
                    (filteredCalves.shuffled(), 1),
                    (filteredCore, 1)
                ])
                plans.append(GeneratedWorkoutDay(
                    name: "Lower Hypertrophy + Cardio",
                    description: "Lower body volume with cardio finisher",
                    exercises: scaleExercises(lowerHypertrophy, targetCount: exerciseCount) + createCardioFinisher(),
                    iconName: "figure.walk",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "lower body hypertrophy") + " Includes \(cardioMinutes) minutes of cardio finisher."
                ))
            }

            if count >= 6 {
                let fullBody = selectExercisesFrom([
                    (filteredChest.shuffled(), 1),
                    (filteredBack.shuffled(), 1),
                    (filteredQuads.shuffled(), 1),
                    (filteredShoulders.shuffled(), 1),
                    (filteredCore.shuffled(), 1)
                ])
                plans.append(GeneratedWorkoutDay(
                    name: "Full Body + Cardio",
                    description: "Total body workout with cardio finisher",
                    exercises: scaleExercises(fullBody, targetCount: exerciseCount) + createCardioFinisher(),
                    iconName: "figure.strengthtraining.traditional",
                    rationale: generateProfileRationale(profile: profile, exerciseType: "full body") + " Includes \(cardioMinutes) minutes of cardio finisher."
                ))
            }
        }

        return plans
    }

    // MARK: - Profile-Aware Cardio Day Generation (Legacy - kept for backwards compatibility)
    private static func generateCardioDaysForProfile(count: Int, profile: UserProfile) -> [GeneratedWorkoutDay] {
        guard count > 0 else { return [] }

        let goal = profile.goalEnum
        let filteredCardio = getCategoryExercises(category: cardioExercisesList, profile: profile)

        var plans: [GeneratedWorkoutDay] = []

        for i in 0..<count {
            let cardioType = selectCardioTypeForProfile(for: goal, profile: profile, variant: i, availableExercises: filteredCardio)
            plans.append(GeneratedWorkoutDay(
                name: i == 0 ? cardioType.name : "\(cardioType.name) \(i + 1)",
                description: cardioType.description,
                exercises: cardioType.exercises,
                iconName: cardioType.icon,
                rationale: cardioType.rationale
            ))
        }

        return plans
    }

    private static func selectCardioTypeForProfile(for goal: FitnessGoal, profile: UserProfile, variant: Int, availableExercises: [Exercise]) -> (name: String, description: String, exercises: [Exercise], icon: String, rationale: String) {
        let age = profile.age

        // For older adults, prefer low-impact cardio
        if age >= 55 {
            let lowImpactCardio = availableExercises.filter { lowImpactExercises.contains($0.name) }
            return (
                "Low-Impact Cardio",
                "Joint-friendly cardiovascular training",
                Array(lowImpactCardio.shuffled().prefix(3)),
                "figure.indoor.cycle",
                generateProfileRationale(profile: profile, exerciseType: "cardio") + " We've selected low-impact options to protect your joints while still providing effective cardiovascular benefits."
            )
        }

        switch goal {
        case .loseWeight:
            if variant == 0 {
                let hiitExercises = availableExercises.filter { ["Burpees", "Mountain Climbers", "High Knees", "Jump Rope"].contains($0.name) }
                return (
                    "HIIT Session",
                    "High-intensity intervals to maximize calorie burn",
                    Array(hiitExercises.shuffled().prefix(4)),
                    "figure.highintensity.intervaltraining",
                    generateProfileRationale(profile: profile, exerciseType: "HIIT") + " HIIT elevates your metabolism for hours after the workout."
                )
            } else {
                let metabolicExercises = availableExercises.filter { ["Kettlebell Swings", "Burpees", "Battle Ropes", "Box Jumps", "Mountain Climbers"].contains($0.name) }
                return (
                    "Metabolic Conditioning",
                    "Circuit-style cardio for sustained calorie burn",
                    Array(metabolicExercises.shuffled().prefix(4)),
                    "figure.run",
                    generateProfileRationale(profile: profile, exerciseType: "metabolic conditioning")
                )
            }

        case .improveEndurance:
            if variant == 0 {
                let steadyState = availableExercises.filter { ["Treadmill Running", "Stationary Bike", "Rowing Machine"].contains($0.name) }
                return (
                    "Steady State Cardio",
                    "Moderate-intensity for building aerobic base",
                    Array(steadyState.shuffled().prefix(2)),
                    "figure.run",
                    generateProfileRationale(profile: profile, exerciseType: "steady state cardio") + " Building an aerobic base improves heart efficiency."
                )
            } else {
                let enduranceExercises = availableExercises.filter { ["Rowing Machine", "Elliptical", "Stair Climber", "Stationary Bike"].contains($0.name) }
                return (
                    "Long Duration Cardio",
                    "Extended cardio for endurance building",
                    Array(enduranceExercises.shuffled().prefix(3)),
                    "figure.indoor.cycle",
                    generateProfileRationale(profile: profile, exerciseType: "endurance cardio")
                )
            }

        case .buildMuscle, .increaseStrength:
            let recoveryCardio = availableExercises.filter { ["Stationary Bike", "Elliptical", "Rowing Machine"].contains($0.name) }
            return (
                "Active Recovery Cardio",
                "Light cardio to aid muscle recovery",
                Array(recoveryCardio.shuffled().prefix(2)),
                "figure.walk",
                generateProfileRationale(profile: profile, exerciseType: "active recovery") + " Light cardio aids muscle recovery without impacting strength gains."
            )

        default:
            let mixedCardio = availableExercises.shuffled()
            return (
                "Mixed Cardio",
                "Variety of cardio exercises for overall fitness",
                Array(mixedCardio.prefix(4)),
                "figure.mixed.cardio",
                generateProfileRationale(profile: profile, exerciseType: "mixed cardio")
            )
        }
    }

    // Helper function for selecting exercises from filtered categories
    private static func selectExercisesFrom(_ categories: [(exercises: [Exercise], count: Int)]) -> [Exercise] {
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

    private static func generateStrengthDays(count: Int, goal: FitnessGoal, experience: ExperienceLevel) -> [GeneratedWorkoutDay] {
        switch count {
        case 0:
            return []
        case 1:
            return [
                GeneratedWorkoutDay(
                    name: "Full Body Strength",
                    description: "Complete strength workout targeting all major muscle groups",
                    exercises: adjustExercisesForGoal(selectExercises([
                        (chestExercises, 2),
                        (backExercises, 2),
                        (quadExercises, 2),
                        (shoulderExercises, 1),
                        (coreExercises, 1)
                    ]), goal: goal),
                    iconName: "figure.strengthtraining.traditional",
                    rationale: generateRationale(for: goal, exerciseType: "full body strength")
                )
            ]
        case 2:
            return [
                GeneratedWorkoutDay(
                    name: "Upper Body",
                    description: "Chest, back, shoulders, and arms",
                    exercises: adjustExercisesForGoal(selectExercises([
                        (chestExercises, 2),
                        (backExercises, 2),
                        (shoulderExercises, 2),
                        (bicepExercises, 1),
                        (tricepExercises, 1)
                    ]), goal: goal),
                    iconName: "figure.arms.open",
                    rationale: generateRationale(for: goal, exerciseType: "upper body")
                ),
                GeneratedWorkoutDay(
                    name: "Lower Body",
                    description: "Quads, hamstrings, glutes, and calves",
                    exercises: adjustExercisesForGoal(selectExercises([
                        (quadExercises, 3),
                        (hamstringExercises, 2),
                        (gluteExercises, 1),
                        (calfExercises, 1),
                        (coreExercises, 1)
                    ]), goal: goal),
                    iconName: "figure.walk",
                    rationale: generateRationale(for: goal, exerciseType: "lower body")
                )
            ]
        case 3:
            return [
                GeneratedWorkoutDay(
                    name: "Push",
                    description: "Chest, shoulders, and triceps",
                    exercises: adjustExercisesForGoal(selectExercises([
                        (chestExercises, 3),
                        (shoulderExercises, 2),
                        (tricepExercises, 2)
                    ]), goal: goal),
                    iconName: "arrow.up.circle.fill",
                    rationale: generateRationale(for: goal, exerciseType: "push muscles")
                ),
                GeneratedWorkoutDay(
                    name: "Pull",
                    description: "Back and biceps",
                    exercises: adjustExercisesForGoal(selectExercises([
                        (backExercises, 4),
                        (bicepExercises, 2),
                        (shoulderExercises.filter { $0.muscleGroups.contains("Rear Delts") }, 1)
                    ]), goal: goal),
                    iconName: "arrow.down.circle.fill",
                    rationale: generateRationale(for: goal, exerciseType: "pull muscles")
                ),
                GeneratedWorkoutDay(
                    name: "Legs",
                    description: "Quads, hamstrings, glutes, and calves",
                    exercises: adjustExercisesForGoal(selectExercises([
                        (quadExercises, 3),
                        (hamstringExercises, 2),
                        (gluteExercises, 1),
                        (calfExercises, 1)
                    ]), goal: goal),
                    iconName: "figure.walk.circle.fill",
                    rationale: generateRationale(for: goal, exerciseType: "leg muscles")
                )
            ]
        default:
            return generateFourPlusStrengthDays(count: count, goal: goal)
        }
    }

    private static func generateFourPlusStrengthDays(count: Int, goal: FitnessGoal) -> [GeneratedWorkoutDay] {
        var plans: [GeneratedWorkoutDay] = []

        // Add Push day
        plans.append(GeneratedWorkoutDay(
            name: "Push",
            description: "Chest, shoulders, and triceps",
            exercises: adjustExercisesForGoal(selectExercises([
                (chestExercises, 3),
                (shoulderExercises, 2),
                (tricepExercises, 2)
            ]), goal: goal),
            iconName: "arrow.up.circle.fill",
            rationale: generateRationale(for: goal, exerciseType: "push muscles")
        ))

        // Add Pull day
        plans.append(GeneratedWorkoutDay(
            name: "Pull",
            description: "Back and biceps",
            exercises: adjustExercisesForGoal(selectExercises([
                (backExercises, 4),
                (bicepExercises, 2),
                (shoulderExercises.filter { $0.muscleGroups.contains("Rear Delts") }, 1)
            ]), goal: goal),
            iconName: "arrow.down.circle.fill",
            rationale: generateRationale(for: goal, exerciseType: "pull muscles")
        ))

        // Add Legs day
        plans.append(GeneratedWorkoutDay(
            name: "Legs",
            description: "Quads, hamstrings, glutes, and calves",
            exercises: adjustExercisesForGoal(selectExercises([
                (quadExercises, 3),
                (hamstringExercises, 2),
                (gluteExercises, 1),
                (calfExercises, 1)
            ]), goal: goal),
            iconName: "figure.walk.circle.fill",
            rationale: generateRationale(for: goal, exerciseType: "leg muscles")
        ))

        // Add additional days if needed
        if count >= 4 {
            plans.append(GeneratedWorkoutDay(
                name: "Upper Hypertrophy",
                description: "Upper body volume focus",
                exercises: adjustExercisesForGoal(selectExercises([
                    (chestExercises, 2),
                    (backExercises, 2),
                    (shoulderExercises, 2),
                    (bicepExercises, 1),
                    (tricepExercises, 1)
                ]), goal: goal),
                iconName: "figure.arms.open",
                rationale: generateRationale(for: goal, exerciseType: "upper body volume")
            ))
        }

        if count >= 5 {
            plans.append(GeneratedWorkoutDay(
                name: "Lower Hypertrophy",
                description: "Lower body volume focus",
                exercises: adjustExercisesForGoal(selectExercises([
                    (quadExercises, 2),
                    (hamstringExercises, 2),
                    (gluteExercises, 2),
                    (calfExercises, 1),
                    (coreExercises, 1)
                ]), goal: goal),
                iconName: "figure.walk",
                rationale: generateRationale(for: goal, exerciseType: "lower body volume")
            ))
        }

        return plans
    }

    private static func generateCardioDays(count: Int, goal: FitnessGoal, experience: ExperienceLevel) -> [GeneratedWorkoutDay] {
        guard count > 0 else { return [] }

        var plans: [GeneratedWorkoutDay] = []

        // First cardio day - based on goal
        if count >= 1 {
            let cardioType = selectCardioType(for: goal, variant: 0)
            plans.append(GeneratedWorkoutDay(
                name: cardioType.name,
                description: cardioType.description,
                exercises: cardioType.exercises,
                iconName: cardioType.icon,
                rationale: cardioType.rationale
            ))
        }

        // Second cardio day - different style
        if count >= 2 {
            let cardioType = selectCardioType(for: goal, variant: 1)
            plans.append(GeneratedWorkoutDay(
                name: cardioType.name,
                description: cardioType.description,
                exercises: cardioType.exercises,
                iconName: cardioType.icon,
                rationale: cardioType.rationale
            ))
        }

        // Additional cardio days
        for i in 2..<count {
            let cardioType = selectCardioType(for: goal, variant: i)
            plans.append(GeneratedWorkoutDay(
                name: "\(cardioType.name) \(i - 1)",
                description: cardioType.description,
                exercises: cardioType.exercises,
                iconName: cardioType.icon,
                rationale: cardioType.rationale
            ))
        }

        return plans
    }

    private static func selectCardioType(for goal: FitnessGoal, variant: Int) -> (name: String, description: String, exercises: [Exercise], icon: String, rationale: String) {
        switch goal {
        case .loseWeight:
            if variant == 0 {
                return (
                    "HIIT Session",
                    "High-intensity intervals to maximize calorie burn",
                    selectCardioExercises(type: .hiit),
                    "figure.highintensity.intervaltraining",
                    "HIIT training is highly effective for fat loss because it elevates your metabolism for hours after the workout (EPOC effect) and burns more calories in less time than steady-state cardio."
                )
            } else {
                return (
                    "Metabolic Conditioning",
                    "Circuit-style cardio for sustained calorie burn",
                    selectCardioExercises(type: .metabolic),
                    "figure.run",
                    "Metabolic conditioning combines cardio with bodyweight exercises to keep your heart rate elevated throughout, maximizing calorie expenditure and building muscular endurance."
                )
            }

        case .improveEndurance:
            if variant == 0 {
                return (
                    "Steady State Cardio",
                    "Moderate-intensity for building aerobic base",
                    selectCardioExercises(type: .steadyState),
                    "figure.run",
                    "Building an aerobic base with steady-state cardio improves your heart's efficiency and increases your body's ability to use oxygen, which is fundamental for endurance performance."
                )
            } else {
                return (
                    "Long Duration Cardio",
                    "Extended cardio for endurance building",
                    selectCardioExercises(type: .endurance),
                    "figure.indoor.cycle",
                    "Longer duration cardio sessions train your body to efficiently use fat as fuel and improve your mental stamina for extended physical activity."
                )
            }

        case .buildMuscle, .increaseStrength:
            return (
                "Active Recovery Cardio",
                "Light cardio to aid muscle recovery",
                selectCardioExercises(type: .recovery),
                "figure.walk",
                "Light cardio on rest days increases blood flow to muscles, helping deliver nutrients for recovery while burning a few extra calories without impacting your strength gains."
            )

        case .generalFitness, .toneUp:
            if variant == 0 {
                return (
                    "Mixed Cardio",
                    "Variety of cardio exercises for overall fitness",
                    selectCardioExercises(type: .mixed),
                    "figure.mixed.cardio",
                    "A variety of cardio types keeps workouts interesting and challenges your body in different ways, preventing plateaus and building well-rounded fitness."
                )
            } else {
                return (
                    "Cardio Circuit",
                    "Fun cardio circuit to boost heart health",
                    selectCardioExercises(type: .circuit),
                    "figure.highintensity.intervaltraining",
                    "Circuit-style cardio builds cardiovascular fitness while also engaging multiple muscle groups, helping you achieve a toned, defined physique."
                )
            }
        }
    }

    private enum CardioType {
        case hiit, metabolic, steadyState, endurance, recovery, mixed, circuit
    }

    private static func selectCardioExercises(type: CardioType) -> [Exercise] {
        switch type {
        case .hiit:
            return [
                cardioExercisesList.first { $0.name == "Burpees" }!,
                cardioExercisesList.first { $0.name == "Mountain Climbers" }!,
                cardioExercisesList.first { $0.name == "High Knees" }!,
                cardioExercisesList.first { $0.name == "Jump Rope" }!
            ]
        case .metabolic:
            return [
                cardioExercisesList.first { $0.name == "Kettlebell Swings" }!,
                cardioExercisesList.first { $0.name == "Burpees" }!,
                cardioExercisesList.first { $0.name == "Battle Ropes" }!,
                cardioExercisesList.first { $0.name == "Box Jumps" }!
            ]
        case .steadyState:
            return [
                cardioExercisesList.first { $0.name == "Treadmill Running" }!,
                cardioExercisesList.first { $0.name == "Stationary Bike" }!
            ]
        case .endurance:
            return [
                cardioExercisesList.first { $0.name == "Rowing Machine" }!,
                cardioExercisesList.first { $0.name == "Elliptical" }!,
                cardioExercisesList.first { $0.name == "Stair Climber" }!
            ]
        case .recovery:
            return [
                cardioExercisesList.first { $0.name == "Stationary Bike" }!,
                cardioExercisesList.first { $0.name == "Elliptical" }!
            ]
        case .mixed:
            return [
                cardioExercisesList.first { $0.name == "Treadmill Running" }!,
                cardioExercisesList.first { $0.name == "Jumping Jacks" }!,
                cardioExercisesList.first { $0.name == "Mountain Climbers" }!
            ]
        case .circuit:
            return [
                cardioExercisesList.first { $0.name == "Jumping Jacks" }!,
                cardioExercisesList.first { $0.name == "High Knees" }!,
                cardioExercisesList.first { $0.name == "Mountain Climbers" }!,
                cardioExercisesList.first { $0.name == "Burpees" }!
            ]
        }
    }

    private static func interleavePlans(strengthPlans: [GeneratedWorkoutDay], cardioPlans: [GeneratedWorkoutDay]) -> [GeneratedWorkoutDay] {
        var result: [GeneratedWorkoutDay] = []
        var strengthIndex = 0
        var cardioIndex = 0

        let total = strengthPlans.count + cardioPlans.count

        for i in 0..<total {
            // Alternate between strength and cardio, with strength first
            if strengthIndex < strengthPlans.count && (cardioIndex >= cardioPlans.count || i % 2 == 0) {
                result.append(strengthPlans[strengthIndex])
                strengthIndex += 1
            } else if cardioIndex < cardioPlans.count {
                result.append(cardioPlans[cardioIndex])
                cardioIndex += 1
            }
        }

        return result
    }

    private static func adjustExercisesForGoal(_ exercises: [Exercise], goal: FitnessGoal) -> [Exercise] {
        let setsRange = goal.recommendedSetsRange
        let repsRange = goal.recommendedRepsRange

        return exercises.map { exercise in
            Exercise(
                id: exercise.id,
                name: exercise.name,
                muscleGroups: exercise.muscleGroups,
                instructions: exercise.instructions,
                imageName: exercise.imageName,
                videoURL: exercise.videoURL,
                gifURL: exercise.gifURL,
                defaultSets: Int.random(in: setsRange),
                defaultReps: Int.random(in: repsRange),
                formTips: exercise.formTips,
                exerciseType: exercise.exerciseType,
                caloriesPerMinute: exercise.caloriesPerMinute
            )
        }
    }

    private static func generateRationale(for goal: FitnessGoal, exerciseType: String) -> String {
        switch goal {
        case .loseWeight:
            return "This \(exerciseType) workout is designed to maximize calorie burn with moderate weights and higher repetitions. The exercises selected are compound movements that engage multiple muscle groups, increasing your metabolic rate both during and after your workout."

        case .buildMuscle:
            return "This \(exerciseType) workout focuses on hypertrophy (muscle growth) with moderate to heavy weights and 8-12 reps per set. The exercises target your muscles from multiple angles to stimulate maximum growth and achieve a well-developed physique."

        case .improveEndurance:
            return "This \(exerciseType) workout uses lighter weights with higher repetitions to build muscular endurance. Combined with your cardio sessions, these exercises will help your muscles work efficiently for longer periods."

        case .generalFitness:
            return "This \(exerciseType) workout provides a balanced approach with moderate weights and reps. The exercise selection ensures you build functional strength that translates to everyday activities while maintaining good overall fitness."

        case .increaseStrength:
            return "This \(exerciseType) workout emphasizes heavy compound movements with lower reps to maximize strength gains. The focus is on progressively overloading your muscles with challenging weights to build raw power."

        case .toneUp:
            return "This \(exerciseType) workout uses moderate weights with higher reps to build lean muscle definition without excessive bulk. The exercises selected will help sculpt and define your muscles for a toned appearance."
        }
    }

    // MARK: - Split Routines (Legacy methods)
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
                adjusted = Exercise(
                    id: exercise.id,
                    name: exercise.name,
                    muscleGroups: exercise.muscleGroups,
                    instructions: exercise.instructions,
                    imageName: exercise.imageName,
                    videoURL: exercise.videoURL,
                    gifURL: exercise.gifURL,
                    defaultSets: min(exercise.defaultSets + 1, 5),
                    defaultReps: exercise.defaultReps + 2,
                    formTips: exercise.formTips,
                    exerciseType: exercise.exerciseType,
                    caloriesPerMinute: exercise.caloriesPerMinute
                )
            case .tooHard:
                adjusted = Exercise(
                    id: exercise.id,
                    name: exercise.name,
                    muscleGroups: exercise.muscleGroups,
                    instructions: exercise.instructions,
                    imageName: exercise.imageName,
                    videoURL: exercise.videoURL,
                    gifURL: exercise.gifURL,
                    defaultSets: max(exercise.defaultSets - 1, 2),
                    defaultReps: max(exercise.defaultReps - 2, 6),
                    formTips: exercise.formTips,
                    exerciseType: exercise.exerciseType,
                    caloriesPerMinute: exercise.caloriesPerMinute
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
    var rationale: String = ""

    var exerciseNames: [String] {
        exercises.map { $0.name }
    }

    var estimatedDuration: Int {
        exercises.count * 7 // ~7 minutes per exercise
    }

    var estimatedCalories: Int {
        exercises.reduce(0) { total, exercise in
            let durationMinutes = exercise.exerciseType == .cardio ? exercise.defaultReps : (exercise.defaultSets * 2)
            return total + (exercise.caloriesPerMinute * durationMinutes)
        }
    }

    var isCardioDay: Bool {
        exercises.allSatisfy { $0.isCardio }
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
