import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise

    private var videoURL: String? {
        exercise.videoURL ?? ExerciseVideoLibrary.getVideoURL(for: exercise.name)
    }

    private var formTips: [String] {
        exercise.formTips.isEmpty ? ExerciseVideoLibrary.getFormTips(for: exercise.name) : exercise.formTips
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Exercise Image/Icon
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 120, height: 120)

                    Image(systemName: exercise.imageName)
                        .font(.system(size: 50))
                        .foregroundStyle(.blue)
                }
                .padding(.top)

                // Exercise Name and Muscles
                VStack(spacing: 8) {
                    Text(exercise.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text(exercise.muscleGroups.joined(separator: " • "))
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }

                // Video Section
                if let urlString = videoURL, let url = URL(string: urlString) {
                    VideoLinkSection(url: url)
                }

                // Recommended Sets/Reps
                HStack(spacing: 40) {
                    VStack(spacing: 4) {
                        Text("\(exercise.defaultSets)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundStyle(.blue)
                        Text("Sets")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Rectangle()
                        .fill(Color.secondary.opacity(0.3))
                        .frame(width: 1, height: 50)

                    VStack(spacing: 4) {
                        Text("\(exercise.defaultReps)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundStyle(.blue)
                        Text("Reps")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)

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
                .cornerRadius(16)

                // Form Tips Section
                if !formTips.isEmpty {
                    FormTipsSection(tips: formTips)
                }

                // Target Muscles
                VStack(alignment: .leading, spacing: 12) {
                    Label("Target Muscles", systemImage: "figure.strengthtraining.traditional")
                        .font(.headline)

                    FlowLayout(spacing: 8) {
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
                .cornerRadius(16)

                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Video Link Section
struct VideoLinkSection: View {
    let url: URL
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Video Demonstration", systemImage: "play.rectangle.fill")
                .font(.headline)

            Button(action: {
                openURL(url)
            }) {
                HStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.red.opacity(0.1))
                            .frame(width: 80, height: 60)

                        Image(systemName: "play.fill")
                            .font(.title2)
                            .foregroundStyle(.red)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Watch Form Guide")
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Text("Learn proper technique and alignment")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Image(systemName: "arrow.up.right.square")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Form Tips Section
struct FormTipsSection: View {
    let tips: [String]
    @State private var isExpanded = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Label("Form Tips", systemImage: "checkmark.shield.fill")
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)

            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(tips.enumerated()), id: \.offset) { index, tip in
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
                .padding(.top, 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.green.opacity(0.05))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.green.opacity(0.2), lineWidth: 1)
        )
        .cornerRadius(16)
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, spacing: spacing, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, spacing: spacing, subviews: subviews)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x,
                                      y: bounds.minY + result.positions[index].y),
                          proposal: .unspecified)
        }
    }

    struct FlowResult {
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
    NavigationStack {
        ExerciseDetailView(exercise: SampleWorkouts.benchPress)
    }
}
