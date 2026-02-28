import SwiftUI

struct HomeView: View {
    @State private var suggested = MysterySet.suggestedToday()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {
                    Spacer().frame(height: 20)

                    // Cross icon
                    Image(systemName: "cross.fill")
                        .font(.system(size: 52, weight: .thin))
                        .foregroundStyle(RosaryTheme.gold)
                        .shadow(color: RosaryTheme.gold.opacity(0.4), radius: 12)
                        .accessibilityHidden(true)

                    // Title
                    VStack(spacing: 6) {
                        Text("The Holy Rosary")
                            .font(.system(.largeTitle, design: .serif))
                            .fontWeight(.bold)
                            .foregroundStyle(RosaryTheme.cream)

                        Text("\(MysterySet.dayName()) — \(suggested.rawValue) Mysteries")
                            .font(.system(.subheadline, design: .serif))
                            .foregroundStyle(RosaryTheme.muted)
                    }

                    // Mystery set cards
                    VStack(spacing: 12) {
                        ForEach(MysterySet.allCases) { set in
                            NavigationLink(destination: RosaryView(mysterySet: set)) {
                                mysteryCard(set: set)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)

                    // Stats
                    HStack(spacing: 32) {
                        statBadge(label: "Today", count: RosaryTracker.todayCount())
                        statBadge(label: "Total", count: RosaryTracker.totalCount())
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 40)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    colors: [RosaryTheme.darkBg, Color(red: 0.05, green: 0.03, blue: 0.08)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationBarHidden(true)
        }
    }

    // MARK: - Mystery Card

    private func mysteryCard(set: MysterySet) -> some View {
        HStack(spacing: 14) {
            Image(systemName: set.icon)
                .font(.title2)
                .foregroundStyle(RosaryTheme.gold)
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 2) {
                Text("\(set.rawValue) Mysteries")
                    .font(.system(.body, design: .serif))
                    .fontWeight(.semibold)
                    .foregroundStyle(RosaryTheme.cream)
                Text(set.subtitle)
                    .font(.caption)
                    .foregroundStyle(RosaryTheme.muted)
            }

            Spacer()

            if set == suggested {
                Text("Today")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(RosaryTheme.darkBg)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(RosaryTheme.gold, in: Capsule())
            }

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(RosaryTheme.muted)
                .accessibilityHidden(true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(RosaryTheme.cardBg, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(RosaryTheme.gold.opacity(set == suggested ? 0.4 : 0.1), lineWidth: 1)
        )
    }

    // MARK: - Stat Badge

    private func statBadge(label: String, count: Int) -> some View {
        VStack(spacing: 4) {
            Text("\(count)")
                .font(.system(.title2, design: .serif))
                .fontWeight(.bold)
                .foregroundStyle(RosaryTheme.gold)
            Text(label)
                .font(.caption)
                .foregroundStyle(RosaryTheme.muted)
        }
    }
}

#Preview { HomeView() }
