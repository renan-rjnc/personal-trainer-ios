import Foundation

// MARK: - Exercise Type
enum ExerciseType: String, Codable {
    case strength = "Strength"
    case cardio = "Cardio"
    case flexibility = "Flexibility"
    case compound = "Compound"
}

struct Exercise: Identifiable, Hashable {
    let id: UUID
    let name: String
    let muscleGroups: [String]
    let instructions: String
    let imageName: String
    let videoURL: String?
    let gifURL: String?  // Animated GIF for visual demonstration
    let defaultSets: Int
    let defaultReps: Int
    let formTips: [String]
    let exerciseType: ExerciseType
    let caloriesPerMinute: Int  // Estimated calories burned per minute

    init(
        id: UUID = UUID(),
        name: String,
        muscleGroups: [String],
        instructions: String,
        imageName: String = "figure.strengthtraining.traditional",
        videoURL: String? = nil,
        gifURL: String? = nil,
        defaultSets: Int = 3,
        defaultReps: Int = 10,
        formTips: [String] = [],
        exerciseType: ExerciseType = .strength,
        caloriesPerMinute: Int = 5
    ) {
        self.id = id
        self.name = name
        self.muscleGroups = muscleGroups
        self.instructions = instructions
        self.imageName = imageName
        self.videoURL = videoURL
        self.gifURL = gifURL
        self.defaultSets = defaultSets
        self.defaultReps = defaultReps
        self.formTips = formTips
        self.exerciseType = exerciseType
        self.caloriesPerMinute = caloriesPerMinute
    }

    var isCardio: Bool {
        exerciseType == .cardio
    }
}

// MARK: - Exercise Video Data
struct ExerciseVideoLibrary {
    // Video URLs from free exercise demonstration sources
    // Using short-form video URLs that demonstrate proper form
    static let videos: [String: String] = [
        // Chest
        "Bench Press": "https://www.youtube.com/watch?v=rT7DgCr-3pg",
        "Incline Dumbbell Press": "https://www.youtube.com/watch?v=8iPEnn-ltC8",
        "Dumbbell Flyes": "https://www.youtube.com/watch?v=eozdVDA78K0",
        "Push-Ups": "https://www.youtube.com/watch?v=IODxDxX7oi4",
        "Cable Crossover": "https://www.youtube.com/watch?v=taI4XduLpTk",

        // Back
        "Deadlift": "https://www.youtube.com/watch?v=op9kVnSso6Q",
        "Pull-Ups": "https://www.youtube.com/watch?v=eGo4IYlbE5g",
        "Barbell Rows": "https://www.youtube.com/watch?v=FWJR5Ve8bnQ",
        "Lat Pulldown": "https://www.youtube.com/watch?v=CAwf7n6Luuc",
        "Seated Cable Row": "https://www.youtube.com/watch?v=GZbfZ033f74",
        "Face Pulls": "https://www.youtube.com/watch?v=rep-qVOkqgk",
        "Dumbbell Rows": "https://www.youtube.com/watch?v=roCP6wCXPqo",

        // Shoulders
        "Overhead Press": "https://www.youtube.com/watch?v=2yjwXTZQDDI",
        "Lateral Raises": "https://www.youtube.com/watch?v=3VcKaXpzqRo",
        "Front Raises": "https://www.youtube.com/watch?v=gzDRaW5Fntc",
        "Arnold Press": "https://www.youtube.com/watch?v=6Z15_WdXmVw",
        "Reverse Flyes": "https://www.youtube.com/watch?v=oLwTC-lAJws",

        // Arms
        "Bicep Curls": "https://www.youtube.com/watch?v=ykJmrZ5v0Oo",
        "Hammer Curls": "https://www.youtube.com/watch?v=zC3nLlEvin4",
        "Preacher Curls": "https://www.youtube.com/watch?v=fIWP-FRFNU0",
        "Incline Dumbbell Curls": "https://www.youtube.com/watch?v=soxrZlIl35U",
        "Tricep Dips": "https://www.youtube.com/watch?v=0326dy_-CzM",
        "Tricep Pushdown": "https://www.youtube.com/watch?v=2-LAMcpzODU",
        "Skull Crushers": "https://www.youtube.com/watch?v=d_KZxkY_0cM",
        "Overhead Tricep Extension": "https://www.youtube.com/watch?v=_gsUck-7M74",

        // Legs
        "Barbell Squats": "https://www.youtube.com/watch?v=ultWZbUMPL8",
        "Leg Press": "https://www.youtube.com/watch?v=IZxyjW7MPJQ",
        "Leg Extensions": "https://www.youtube.com/watch?v=YyvSfVjQeL0",
        "Walking Lunges": "https://www.youtube.com/watch?v=L8fvypPrzzs",
        "Bulgarian Split Squats": "https://www.youtube.com/watch?v=2C-uNgKwPLE",
        "Goblet Squats": "https://www.youtube.com/watch?v=MeIiIdhvXT4",
        "Romanian Deadlift": "https://www.youtube.com/watch?v=JCXUYuzwNrM",
        "Leg Curls": "https://www.youtube.com/watch?v=1Tq3QdYUuHs",
        "Hip Thrusts": "https://www.youtube.com/watch?v=SEdqd1n0cvg",
        "Glute Bridges": "https://www.youtube.com/watch?v=OUgsJ8-Vi0E",
        "Good Mornings": "https://www.youtube.com/watch?v=YA-h3n9L4YU",
        "Calf Raises": "https://www.youtube.com/watch?v=-M4-G8p8fmc",
        "Seated Calf Raises": "https://www.youtube.com/watch?v=JbyjNymZOt0",

        // Core
        "Planks": "https://www.youtube.com/watch?v=ASdvN_XEl_c",
        "Cable Crunches": "https://www.youtube.com/watch?v=AV5PmTNWUPQ",
        "Hanging Leg Raises": "https://www.youtube.com/watch?v=hdng3Nm1x_E",
        "Russian Twists": "https://www.youtube.com/watch?v=wkD8rjkodUI"
    ]

    // Form tips for proper alignment and technique
    static let formTips: [String: [String]] = [
        // Chest
        "Bench Press": [
            "Keep feet flat on the floor, shoulder-width apart",
            "Maintain a slight arch in your lower back",
            "Grip the bar slightly wider than shoulder-width",
            "Lower the bar to mid-chest, not to the neck",
            "Keep wrists straight, not bent backward",
            "Drive your shoulder blades into the bench"
        ],
        "Incline Dumbbell Press": [
            "Set bench at 30-45 degrees, not too steep",
            "Keep elbows at 45-degree angle from body",
            "Don't let dumbbells drift too wide at the bottom",
            "Press up in a slight arc, bringing weights together",
            "Keep your back flat against the bench"
        ],
        "Push-Ups": [
            "Hands shoulder-width apart or slightly wider",
            "Keep body in a straight line from head to heels",
            "Don't let hips sag or pike up",
            "Lower until chest nearly touches the ground",
            "Keep core engaged throughout the movement"
        ],

        // Back
        "Deadlift": [
            "Bar should be over mid-foot before lifting",
            "Keep back flat, never rounded",
            "Push through your heels, not your toes",
            "Keep the bar close to your body throughout",
            "Lock out by driving hips forward, not by leaning back",
            "Shoulders should be slightly in front of the bar at start"
        ],
        "Pull-Ups": [
            "Start from a dead hang with arms fully extended",
            "Initiate the pull by depressing your shoulder blades",
            "Pull until chin clears the bar",
            "Avoid swinging or kipping",
            "Keep core tight to prevent excessive swinging"
        ],
        "Barbell Rows": [
            "Hinge at hips with back at 45-degree angle",
            "Keep back flat, not rounded",
            "Pull bar to lower chest/upper abs",
            "Keep elbows close to body",
            "Squeeze shoulder blades together at the top"
        ],

        // Shoulders
        "Overhead Press": [
            "Start with bar at collarbone level",
            "Keep core tight and squeeze glutes",
            "Press bar straight up, moving head back slightly",
            "Lock out arms fully overhead",
            "Don't lean back excessively"
        ],
        "Lateral Raises": [
            "Keep slight bend in elbows throughout",
            "Raise arms to shoulder height, not higher",
            "Lead with elbows, not hands",
            "Control the weight on the way down",
            "Avoid using momentum or swinging"
        ],

        // Arms
        "Bicep Curls": [
            "Keep elbows pinned to your sides",
            "Don't swing the weight or use momentum",
            "Fully extend arms at the bottom",
            "Squeeze biceps at the top of the movement",
            "Control the descent, don't drop the weight"
        ],
        "Tricep Pushdown": [
            "Keep elbows locked at your sides",
            "Only forearms should move",
            "Fully extend arms at the bottom",
            "Don't lean forward excessively",
            "Squeeze triceps at full extension"
        ],

        // Legs
        "Barbell Squats": [
            "Feet shoulder-width apart, toes slightly out",
            "Keep chest up and back straight",
            "Squat until thighs are parallel or below",
            "Push knees out in line with toes",
            "Drive through heels, not toes",
            "Keep the bar centered over mid-foot"
        ],
        "Romanian Deadlift": [
            "Start with bar at hip level, not floor",
            "Keep legs slightly bent, not locked",
            "Push hips back as you lower the bar",
            "Keep bar close to legs throughout",
            "Feel the stretch in hamstrings, not back",
            "Stop when you feel the hamstring stretch"
        ],
        "Leg Press": [
            "Place feet shoulder-width apart on platform",
            "Don't let knees cave inward",
            "Lower until thighs are at 90 degrees",
            "Don't lock out knees at the top",
            "Keep lower back pressed against the pad"
        ],

        // Core
        "Planks": [
            "Keep body in a straight line",
            "Don't let hips sag or pike up",
            "Engage core by drawing belly button in",
            "Keep neck neutral, looking at the floor",
            "Squeeze glutes to help stabilize"
        ]
    ]

    // Cardio exercise videos
    static let cardioVideos: [String: String] = [
        "Treadmill Running": "https://www.youtube.com/watch?v=8iPEnn-ltC8",
        "Stationary Bike": "https://www.youtube.com/watch?v=nhLQryJpWf8",
        "Rowing Machine": "https://www.youtube.com/watch?v=H0r2tXrJzqc",
        "Jumping Jacks": "https://www.youtube.com/watch?v=c4DAnQ6DtF8",
        "Burpees": "https://www.youtube.com/watch?v=TU8QYVW0gDU",
        "Mountain Climbers": "https://www.youtube.com/watch?v=nmwgirgXLYM",
        "High Knees": "https://www.youtube.com/watch?v=D0jBMqvtRdI",
        "Box Jumps": "https://www.youtube.com/watch?v=52r_Ul5k03g",
        "Jump Rope": "https://www.youtube.com/watch?v=u3zgHI8QnqE",
        "Battle Ropes": "https://www.youtube.com/watch?v=a3lCPJwVzLM",
        "Stair Climber": "https://www.youtube.com/watch?v=jsvOPssDVbA",
        "Elliptical": "https://www.youtube.com/watch?v=NRv7RK1vhjg",
        "Kettlebell Swings": "https://www.youtube.com/watch?v=YSxHifyI6s8",
        "Sprint Intervals": "https://www.youtube.com/watch?v=yNgUwCjrsb4"
    ]

    // GIF URLs for animated exercise demonstrations (using Tenor/GIPHY style URLs)
    static let gifURLs: [String: String] = [
        // Chest
        "Bench Press": "https://media.giphy.com/media/7YCC7SFeGLfOYUKmkk/giphy.gif",
        "Push-Ups": "https://media.giphy.com/media/Kajz5FMHMxKzC7ZHLL/giphy.gif",
        "Incline Dumbbell Press": "https://media.giphy.com/media/3ohzAqBhmBWGLT6LDy/giphy.gif",

        // Back
        "Deadlift": "https://media.giphy.com/media/1qfKN8Dt0CRdCRxz9q/giphy.gif",
        "Pull-Ups": "https://media.giphy.com/media/ua7vVw9awZKWwLSYpW/giphy.gif",
        "Barbell Rows": "https://media.giphy.com/media/3oz8xM1ZynfjRcRoY8/giphy.gif",

        // Shoulders
        "Overhead Press": "https://media.giphy.com/media/xTiTnvtv1hNp9tIpTW/giphy.gif",
        "Lateral Raises": "https://media.giphy.com/media/l0IylOPCNkiqOgMyA/giphy.gif",

        // Arms
        "Bicep Curls": "https://media.giphy.com/media/7YCC7SFeGLfOYUKmkk/giphy.gif",
        "Tricep Pushdown": "https://media.giphy.com/media/3ohzdMk3uz9WSpdTvW/giphy.gif",

        // Legs
        "Barbell Squats": "https://media.giphy.com/media/1qfKN8Dt0CRdCRxz9q/giphy.gif",
        "Leg Press": "https://media.giphy.com/media/xT0xem7ZlZ2DOYqpG0/giphy.gif",
        "Walking Lunges": "https://media.giphy.com/media/3ohs4rclkSSrNGSlFK/giphy.gif",

        // Cardio
        "Burpees": "https://media.giphy.com/media/23hPPMRgPxbNBlPQe3/giphy.gif",
        "Jumping Jacks": "https://media.giphy.com/media/l0HlNQ03J5JxX6lva/giphy.gif",
        "Mountain Climbers": "https://media.giphy.com/media/xTiTnvtv1hNp9tIpTW/giphy.gif",
        "High Knees": "https://media.giphy.com/media/l0HlKfxwsROuoJu5W/giphy.gif",
        "Jump Rope": "https://media.giphy.com/media/3o7btUg31OCi0NXdkY/giphy.gif"
    ]

    // Cardio form tips
    static let cardioFormTips: [String: [String]] = [
        "Treadmill Running": [
            "Maintain upright posture, don't lean forward",
            "Land on midfoot, not heels",
            "Keep arms at 90 degrees, swing naturally",
            "Start with a warm-up walk",
            "Don't hold onto the handrails"
        ],
        "Burpees": [
            "Start standing, then squat down with hands on floor",
            "Jump feet back into plank position",
            "Perform a push-up (optional)",
            "Jump feet back to hands",
            "Explode up with arms overhead"
        ],
        "Mountain Climbers": [
            "Start in high plank position",
            "Keep core tight and back flat",
            "Drive knees toward chest alternately",
            "Keep hips level, don't bounce",
            "Maintain steady breathing"
        ],
        "Jump Rope": [
            "Keep elbows close to body",
            "Use wrists to turn the rope, not arms",
            "Jump only 1-2 inches off ground",
            "Land softly on balls of feet",
            "Keep core engaged throughout"
        ],
        "Rowing Machine": [
            "Push with legs first, then pull with arms",
            "Keep back straight, don't round",
            "Drive through heels on the push",
            "Pull handle to lower chest",
            "Return arms first, then bend knees"
        ],
        "Kettlebell Swings": [
            "Hinge at hips, not squat",
            "Keep arms relaxed, power comes from hips",
            "Squeeze glutes at the top",
            "Let the kettlebell swing naturally",
            "Keep core braced throughout"
        ]
    ]

    static func getVideoURL(for exerciseName: String) -> String? {
        return videos[exerciseName] ?? cardioVideos[exerciseName]
    }

    static func getFormTips(for exerciseName: String) -> [String] {
        return formTips[exerciseName] ?? cardioFormTips[exerciseName] ?? []
    }

    static func getGifURL(for exerciseName: String) -> String? {
        return gifURLs[exerciseName]
    }
}
