import SwiftUI

enum ExerciseStatus {
    case pending
    case done
    case skipped
}

struct ActiveWorkoutView: View {
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    let workout: WorkoutPlan
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingExitAlert = false
    @State private var showingFinishAlert = false
    @State private var exerciseStatuses: [UUID: ExerciseStatus] = [:]
    @State private var selectedExerciseIndex: Int = 0

    // Use the workout from viewModel if available (for replacements), otherwise use original
    private var currentExercises: [Exercise] {
        workoutViewModel.currentWorkout?.exercises ?? workout.exercises
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress indicators
                exerciseProgressIndicator
                    .padding(.horizontal)
                    .padding(.top, 8)

                // Timer Section (compact)
                compactTimerSection
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))

                // Swipeable Exercise Pages
                TabView(selection: $selectedExerciseIndex) {
                    ForEach(Array(currentExercises.enumerated()), id: \.element.id) { index, exercise in
                        ExercisePageView(
                            exercise: exercise,
                            exerciseNumber: index + 1,
                            totalExercises: currentExercises.count,
                            status: exerciseStatuses[exercise.id] ?? .pending,
                            workoutViewModel: workoutViewModel,
                            timerViewModel: timerViewModel,
                            onMarkDone: {
                                markExerciseDone(exercise)
                            },
                            onSkip: {
                                skipExercise(exercise)
                            },
                            onReplaceExercise: { newExercise in
                                replaceExercise(at: index, with: newExercise)
                            }
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: selectedExerciseIndex) { _, newIndex in
                    workoutViewModel.currentExerciseIndex = newIndex
                    workoutViewModel.resetCurrentSetForExercise()
                }
            }
            .navigationTitle(workout.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Exit") {
                        showingExitAlert = true
                    }
                    .foregroundStyle(.red)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Finish") {
                        showingFinishAlert = true
                    }
                }
            }
            .alert("Exit Workout?", isPresented: $showingExitAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Exit", role: .destructive) {
                    timerViewModel.reset()
                    workoutViewModel.endWorkout()
                    dismiss()
                }
            } message: {
                Text("Your progress will not be saved.")
            }
            .alert("Finish Workout?", isPresented: $showingFinishAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Finish") {
                    timerViewModel.reset()
                    _ = workoutViewModel.finishWorkout(modelContext: modelContext)
                    dismiss()
                }
            } message: {
                Text("This will save your workout to history.")
            }
            .onAppear {
                // Initialize all exercises as pending
                for exercise in workout.exercises {
                    if exerciseStatuses[exercise.id] == nil {
                        exerciseStatuses[exercise.id] = .pending
                    }
                }
            }
        }
    }

    // MARK: - Progress Indicator
    private var exerciseProgressIndicator: some View {
        HStack(spacing: 4) {
            ForEach(Array(workout.exercises.enumerated()), id: \.element.id) { index, exercise in
                Button(action: {
                    withAnimation {
                        selectedExerciseIndex = index
                    }
                }) {
                    Circle()
                        .fill(statusColor(for: exercise))
                        .frame(width: index == selectedExerciseIndex ? 12 : 8,
                               height: index == selectedExerciseIndex ? 12 : 8)
                        .overlay(
                            Circle()
                                .stroke(index == selectedExerciseIndex ? Color.blue : Color.clear, lineWidth: 2)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 8)
    }

    private func statusColor(for exercise: Exercise) -> Color {
        switch exerciseStatuses[exercise.id] ?? .pending {
        case .done: return .green
        case .skipped: return .orange
        case .pending: return Color(.systemGray4)
        }
    }

    // MARK: - Compact Timer
    private var compactTimerSection: some View {
        HStack(spacing: 16) {
            // Timer Display
            Text(timerViewModel.formattedTime)
                .font(.system(size: 24, weight: .medium, design: .monospaced))
                .foregroundStyle(timerViewModel.isCountdownComplete ? .red : .primary)

            Spacer()

            // Mode Toggle
            Picker("", selection: Binding(
                get: { timerViewModel.mode },
                set: { newMode in
                    if newMode == .stopwatch {
                        timerViewModel.switchToStopwatch()
                    } else {
                        timerViewModel.setCountdown(seconds: 60)
                    }
                }
            )) {
                Image(systemName: "stopwatch").tag(TimerViewModel.TimerMode.stopwatch)
                Image(systemName: "timer").tag(TimerViewModel.TimerMode.countdown)
            }
            .pickerStyle(.segmented)
            .frame(width: 100)

            // Timer Controls
            HStack(spacing: 8) {
                Button(action: {
                    timerViewModel.reset()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.body)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Button(action: {
                    if timerViewModel.isRunning {
                        timerViewModel.pause()
                    } else {
                        timerViewModel.start()
                    }
                }) {
                    Image(systemName: timerViewModel.isRunning ? "pause.fill" : "play.fill")
                        .font(.body)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
            }
        }
    }

    // MARK: - Actions
    private func markExerciseDone(_ exercise: Exercise) {
        exerciseStatuses[exercise.id] = .done
        moveToNextExercise()
    }

    private func skipExercise(_ exercise: Exercise) {
        exerciseStatuses[exercise.id] = .skipped
        moveToNextExercise()
    }

    private func moveToNextExercise() {
        if selectedExerciseIndex < currentExercises.count - 1 {
            withAnimation {
                selectedExerciseIndex += 1
            }
        }
    }

    private func replaceExercise(at index: Int, with newExercise: Exercise) {
        // Update statuses for the new exercise
        let oldExercise = currentExercises[index]
        if let oldStatus = exerciseStatuses[oldExercise.id] {
            exerciseStatuses[newExercise.id] = oldStatus
        }
        exerciseStatuses[oldExercise.id] = nil

        // Replace in the view model
        workoutViewModel.replaceExercise(at: index, with: newExercise)
    }
}

// MARK: - Exercise Page View
struct ExercisePageView: View {
    let exercise: Exercise
    let exerciseNumber: Int
    let totalExercises: Int
    let status: ExerciseStatus
    @Bindable var workoutViewModel: WorkoutViewModel
    @Bindable var timerViewModel: TimerViewModel
    let onMarkDone: () -> Void
    let onSkip: () -> Void
    var onReplaceExercise: ((Exercise) -> Void)?

    @State private var showingFormGuide = false
    @State private var showingReplaceSheet = false

    private var videoURL: String? {
        exercise.videoURL ?? ExerciseVideoLibrary.getVideoURL(for: exercise.name)
    }

    private var formTips: [String] {
        exercise.formTips.isEmpty ? ExerciseVideoLibrary.getFormTips(for: exercise.name) : exercise.formTips
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Exercise Header with Status
                exerciseHeader

                // Form Guide Button
                formGuideSection

                // Set Input Section
                setInputSection

                // Completed Sets
                completedSetsSection

                // Done/Skip Buttons
                actionButtons

                // Swipe hint
                swipeHint
            }
            .padding()
        }
        .sheet(isPresented: $showingFormGuide) {
            FormGuideSheet(exercise: exercise, videoURL: videoURL, formTips: formTips)
        }
        .sheet(isPresented: $showingReplaceSheet) {
            ReplaceExerciseSheet(
                currentExercise: exercise,
                alternatives: workoutViewModel.getAlternativeExercises(for: exercise),
                onSelect: { newExercise in
                    onReplaceExercise?(newExercise)
                    showingReplaceSheet = false
                }
            )
        }
    }

    private var formGuideSection: some View {
        Button(action: {
            showingFormGuide = true
        }) {
            HStack(spacing: 12) {
                Image(systemName: "play.rectangle.fill")
                    .font(.title2)
                    .foregroundStyle(.red)

                VStack(alignment: .leading, spacing: 2) {
                    Text("How to Perform")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)

                    Text("Watch video & form tips")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color.red.opacity(0.1))
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }

    private var exerciseHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Exercise \(exerciseNumber) of \(totalExercises)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                if status != .pending {
                    Label(
                        status == .done ? "Done" : "Skipped",
                        systemImage: status == .done ? "checkmark.circle.fill" : "forward.fill"
                    )
                    .font(.caption)
                    .foregroundStyle(status == .done ? .green : .orange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(status == .done ? Color.green.opacity(0.1) : Color.orange.opacity(0.1))
                    .cornerRadius(8)
                }

                // Replace button
                Button(action: {
                    showingReplaceSheet = true
                }) {
                    Label("Replace", systemImage: "arrow.triangle.2.circlepath")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }

            HStack {
                Image(systemName: exercise.imageName)
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                    .frame(width: 60, height: 60)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 4) {
                    Text(exercise.name)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(exercise.muscleGroups.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("Target: \(exercise.defaultSets) sets × \(exercise.defaultReps) reps")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }

                Spacer()
            }

            Text(exercise.instructions)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }

    private var setInputSection: some View {
        VStack(spacing: 16) {
            Text("Log Set")
                .font(.headline)

            HStack(spacing: 20) {
                VStack {
                    Text("Reps")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack {
                        Button(action: {
                            if workoutViewModel.currentReps > 1 {
                                workoutViewModel.currentReps -= 1
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                        }

                        Text("\(workoutViewModel.currentReps)")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 50)

                        Button(action: {
                            workoutViewModel.currentReps += 1
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                }

                VStack {
                    HStack(spacing: 4) {
                        Text("Weight (lbs)")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        if let lastWeight = workoutViewModel.getLastWeight(for: exercise.name) {
                            Text("• Last: \(Int(lastWeight))")
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }
                    }

                    HStack {
                        Button(action: {
                            if workoutViewModel.currentWeight >= 5 {
                                workoutViewModel.currentWeight -= 5
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                        }

                        Text(String(format: "%.0f", workoutViewModel.currentWeight))
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 60)

                        Button(action: {
                            workoutViewModel.currentWeight += 5
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                }
            }

            Button(action: {
                workoutViewModel.logSet()
                // Auto-start rest timer
                if timerViewModel.mode == .countdown {
                    timerViewModel.reset()
                    timerViewModel.start()
                }
            }) {
                Label("Add Set", systemImage: "plus")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    private var completedSetsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            let setsForExercise = workoutViewModel.completedSets.filter { $0.exerciseName == exercise.name }

            if !setsForExercise.isEmpty {
                Text("Completed Sets")
                    .font(.headline)

                ForEach(setsForExercise) { set in
                    HStack {
                        Text("Set \(set.setNumber)")
                            .fontWeight(.medium)

                        Spacer()

                        Text("\(set.reps) reps")
                        Text("×")
                            .foregroundStyle(.secondary)
                        Text("\(Int(set.weight)) lbs")

                        Button(action: {
                            workoutViewModel.deleteSet(set)
                        }) {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
        }
    }

    private var actionButtons: some View {
        HStack(spacing: 16) {
            Button(action: onSkip) {
                Label("Skip", systemImage: "forward.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.orange)
            .controlSize(.large)

            Button(action: onMarkDone) {
                Label("Done", systemImage: "checkmark")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .controlSize(.large)
        }
    }

    private var swipeHint: some View {
        HStack {
            Image(systemName: "hand.draw")
                .foregroundStyle(.secondary)
            Text("Swipe left or right to navigate exercises")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 8)
    }
}

// MARK: - Form Guide Sheet
struct FormGuideSheet: View {
    let exercise: Exercise
    let videoURL: String?
    let formTips: [String]

    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    private var gifURL: String? {
        exercise.gifURL ?? ExerciseVideoLibrary.getGifURL(for: exercise.name)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Exercise Visual
                    if let gifURLString = gifURL, let url = URL(string: gifURLString) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            case .failure:
                                exerciseIconView
                            @unknown default:
                                exerciseIconView
                            }
                        }
                    } else {
                        exerciseIconView
                    }

                    // Video Button
                    if let urlString = videoURL, let url = URL(string: urlString) {
                        Button(action: {
                            openURL(url)
                        }) {
                            HStack(spacing: 16) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.red.opacity(0.1))
                                        .frame(width: 60, height: 50)

                                    Image(systemName: "play.fill")
                                        .font(.title2)
                                        .foregroundStyle(.red)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Watch Full Video")
                                        .font(.headline)
                                        .foregroundStyle(.primary)

                                    Text("Opens in YouTube")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Image(systemName: "arrow.up.right.square")
                                    .font(.title2)
                                    .foregroundStyle(.red)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .buttonStyle(.plain)
                    }

                    // Instructions
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Instructions", systemImage: "text.alignleft")
                            .font(.headline)

                        Text(exercise.instructions)
                            .font(.body)
                            .lineSpacing(4)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                    // Form Tips
                    if !formTips.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Label("Form Tips", systemImage: "checkmark.shield.fill")
                                .font(.headline)
                                .foregroundStyle(.green)

                            ForEach(Array(formTips.enumerated()), id: \.offset) { index, tip in
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "\(index + 1).circle.fill")
                                        .foregroundStyle(.green)
                                        .font(.body)

                                    Text(tip)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.green.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green.opacity(0.2), lineWidth: 1)
                        )
                        .cornerRadius(12)
                    }

                    // Target Muscles
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Target Muscles", systemImage: "figure.strengthtraining.traditional")
                            .font(.headline)

                        FlowLayoutCompact(spacing: 8) {
                            ForEach(exercise.muscleGroups, id: \.self) { muscle in
                                Text(muscle)
                                    .font(.subheadline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundStyle(.blue)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle(exercise.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private var exerciseIconView: some View {
        ZStack {
            Circle()
                .fill(exercise.isCardio ? Color.orange.opacity(0.1) : Color.blue.opacity(0.1))
                .frame(width: 120, height: 120)

            Image(systemName: exercise.imageName)
                .font(.system(size: 50))
                .foregroundStyle(exercise.isCardio ? .orange : .blue)
        }
    }
}

// MARK: - Replace Exercise Sheet
struct ReplaceExerciseSheet: View {
    let currentExercise: Exercise
    let alternatives: [Exercise]
    let onSelect: (Exercise) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    private var filteredAlternatives: [Exercise] {
        if searchText.isEmpty {
            return alternatives
        }
        return alternatives.filter { exercise in
            exercise.name.localizedCaseInsensitiveContains(searchText) ||
            exercise.muscleGroups.contains { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Current exercise info
                VStack(alignment: .leading, spacing: 8) {
                    Text("Replacing:")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack {
                        Image(systemName: currentExercise.imageName)
                            .font(.title2)
                            .foregroundStyle(.blue)
                            .frame(width: 40, height: 40)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(currentExercise.name)
                                .font(.headline)
                            Text(currentExercise.muscleGroups.joined(separator: ", "))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                }
                .padding()
                .background(Color(.systemGray6))

                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search exercises...", text: $searchText)
                }
                .padding(10)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding()

                // Alternatives list
                if filteredAlternatives.isEmpty {
                    ContentUnavailableView(
                        "No Alternatives Found",
                        systemImage: "figure.strengthtraining.traditional",
                        description: Text("No matching exercises found for the selected muscle groups.")
                    )
                } else {
                    List(filteredAlternatives) { exercise in
                        Button(action: {
                            onSelect(exercise)
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: exercise.imageName)
                                    .font(.title3)
                                    .foregroundStyle(exercise.isCardio ? .orange : .blue)
                                    .frame(width: 36, height: 36)
                                    .background((exercise.isCardio ? Color.orange : Color.blue).opacity(0.1))
                                    .cornerRadius(8)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(exercise.name)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.primary)

                                    Text(exercise.muscleGroups.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)

                                    // Show matching muscles
                                    let matchingMuscles = Set(exercise.muscleGroups).intersection(Set(currentExercise.muscleGroups))
                                    if !matchingMuscles.isEmpty {
                                        HStack(spacing: 4) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.caption2)
                                                .foregroundStyle(.green)
                                            Text("Matches: \(matchingMuscles.joined(separator: ", "))")
                                                .font(.caption2)
                                                .foregroundStyle(.green)
                                        }
                                    }
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Replace Exercise")
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
}

// Simple flow layout for the form guide sheet
struct FlowLayoutCompact: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResultCompact(in: proposal.width ?? 0, spacing: spacing, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResultCompact(in: bounds.width, spacing: spacing, subviews: subviews)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x,
                                      y: bounds.minY + result.positions[index].y),
                          proposal: .unspecified)
        }
    }

    struct FlowResultCompact {
        var size: CGSize = .zero
        var positions: [CGPoint] = []

        init(in maxWidth: CGFloat, spacing: CGFloat, subviews: Subviews) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var rowHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)

                if x + size.width > maxWidth && x > 0 {
                    x = 0
                    y += rowHeight + spacing
                    rowHeight = 0
                }

                positions.append(CGPoint(x: x, y: y))
                rowHeight = max(rowHeight, size.height)
                x += size.width + spacing
            }

            self.size = CGSize(width: maxWidth, height: y + rowHeight)
        }
    }
}

#Preview {
    ActiveWorkoutView(
        workoutViewModel: WorkoutViewModel(),
        timerViewModel: TimerViewModel(),
        workout: SampleWorkouts.pushDay
    )
    .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
