import SwiftUI
import SwiftData

struct HistoryListView: View {
    @Query(sort: \WorkoutSession.date, order: .reverse) private var sessions: [WorkoutSession]
    @Environment(\.modelContext) private var modelContext

    private var groupedSessions: [(String, [WorkoutSession])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: sessions) { session -> String in
            if calendar.isDateInToday(session.date) {
                return "Today"
            } else if calendar.isDateInYesterday(session.date) {
                return "Yesterday"
            } else if calendar.isDate(session.date, equalTo: Date(), toGranularity: .weekOfYear) {
                return "This Week"
            } else if calendar.isDate(session.date, equalTo: Date(), toGranularity: .month) {
                return "This Month"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM yyyy"
                return formatter.string(from: session.date)
            }
        }

        let order = ["Today", "Yesterday", "This Week", "This Month"]
        return grouped.sorted { first, second in
            let firstIndex = order.firstIndex(of: first.key) ?? Int.max
            let secondIndex = order.firstIndex(of: second.key) ?? Int.max
            if firstIndex != secondIndex {
                return firstIndex < secondIndex
            }
            return first.value.first?.date ?? Date() > second.value.first?.date ?? Date()
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if sessions.isEmpty {
                    emptyStateView
                } else {
                    List {
                        ForEach(groupedSessions, id: \.0) { group, groupSessions in
                            Section(group) {
                                ForEach(groupSessions) { session in
                                    NavigationLink(destination: HistoryDetailView(session: session)) {
                                        HistoryRowView(session: session)
                                    }
                                }
                                .onDelete { indexSet in
                                    deleteSession(in: groupSessions, at: indexSet)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "clock.badge.questionmark")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)

            Text("No Workouts Yet")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Complete your first workout to see it here")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    private func deleteSession(in groupSessions: [WorkoutSession], at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(groupSessions[index])
        }
    }
}

struct HistoryRowView: View {
    let session: WorkoutSession

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(session.workoutPlanName)
                    .font(.headline)

                Text(session.formattedDate)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(session.formattedDuration)
                    .font(.headline)
                    .foregroundStyle(.blue)

                Text("\(session.totalSets) sets")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HistoryListView()
        .modelContainer(for: [WorkoutSession.self, ExerciseSet.self], inMemory: true)
}
