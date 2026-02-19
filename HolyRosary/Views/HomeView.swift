import SwiftUI

struct HomeView: View {
    @State private var suggested = MysterySet.suggestedToday()

    private let gold = Color(red: 0.85, green: 0.70, blue: 0.30)

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                Image(systemName: "cross.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(gold)

                Text("Holy Rosary")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Text("Today's suggestion: \(suggested.rawValue)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                VStack(spacing: 16) {
                    ForEach(MysterySet.allCases) { set in
                        NavigationLink(destination: RosaryView(mysterySet: set)) {
                            HStack {
                                Image(systemName: set.icon)
                                    .frame(width: 28)
                                Text("\(set.rawValue) Mysteries")
                                    .fontWeight(.medium)
                                Spacer()
                                if set == suggested {
                                    Text("★")
                                        .foregroundStyle(gold)
                                }
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding()
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(12)
                            .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()

                // Stats
                HStack(spacing: 24) {
                    statBadge(label: "Today", count: RosaryTracker.todayCount())
                    statBadge(label: "Total", count: RosaryTracker.totalCount())
                }
                .padding(.bottom, 32)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
    }

    private func statBadge(label: String, count: Int) -> some View {
        VStack(spacing: 4) {
            Text("\(count)")
                .font(.title2.bold())
                .foregroundStyle(gold)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview { HomeView() }
