import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Exercise Image/Icon
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 150, height: 150)

                    Image(systemName: exercise.imageName)
                        .font(.system(size: 60))
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
