# Personal Trainer iOS

A SwiftUI-based iOS app for personalized workout planning and tracking.

## Features

- **Personalized Workout Generation** - Creates workout plans based on user profile (experience level, available equipment, fitness goals)
- **169 Exercise Library** - Comprehensive exercise database with barbell, dumbbell, and bodyweight variations
- **Exercise Replacement** - Swap exercises during workouts with alternatives targeting the same muscle groups
- **Weight Memory** - Remembers last used weight for each exercise
- **Exercise Demos** - Animated GIFs via ExerciseDB API showing proper form
- **Form Tips** - Detailed guidance for correct exercise technique
- **Workout History** - Track completed sessions with progress over time
- **Rest Timer** - Built-in timer between sets

## Requirements

- iOS 17.0+
- Xcode 15+

## Architecture

- **SwiftUI** - Declarative UI framework
- **SwiftData** - Data persistence
- **MVVM** - Model-View-ViewModel pattern

## Project Structure

```
PersonalTrainer/
├── Models/          # Data models (Exercise, WorkoutPlan, WorkoutSession, UserProfile)
├── Views/           # SwiftUI views organized by feature
├── ViewModels/      # Observable view models
├── Data/            # Workout plan generator and exercise library
└── Assets.xcassets/ # App icons and assets
```

## API Integration

Exercise demonstration GIFs are loaded on-demand from the [ExerciseDB API](https://rapidapi.com/justin-WFnsXH_t6/api/exercisedb) via RapidAPI.

## License

Private project.
