import SwiftUI

struct RosaryView: View {
    @State private var state: RosaryState
    @Environment(\.dismiss) private var dismiss

    init(mysterySet: MysterySet) {
        _state = State(initialValue: RosaryState(mysterySet: mysterySet))
    }

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [RosaryTheme.darkBg, Color(red: 0.05, green: 0.03, blue: 0.08)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            if state.isComplete {
                completionView
            } else {
                prayerView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(state.mysterySet.rawValue)
                    .font(.system(.headline, design: .serif))
                    .foregroundStyle(RosaryTheme.gold)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(state.useLatin ? "EN" : "LA") {
                    state.useLatin.toggle()
                }
                .font(.system(.caption, design: .serif))
                .fontWeight(.semibold)
                .foregroundStyle(RosaryTheme.gold)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    // Swipe left to advance, right to go back
                    if value.translation.width < -30 {
                        advanceBead()
                    } else if value.translation.width > 30 {
                        state.goBack()
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                }
        )
    }

    // MARK: - Advance with haptics

    private func advanceBead() {
        let currentDecade = state.currentStep.decade
        withAnimation(.easeInOut(duration: 0.25)) {
            state.advance()
        }

        if state.isComplete {
            RosaryTracker.record(mysterySet: state.mysterySet)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } else if state.currentStep.decade != currentDecade && state.currentStep.decade != nil {
            // New decade — stronger haptic
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        } else {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
    }

    // MARK: - Prayer View

    private var prayerView: some View {
        VStack(spacing: 16) {
            // Mystery info
            if let mystery = state.currentMystery {
                VStack(spacing: 8) {
                    Text("— Decade \(state.currentStep.decade ?? 0) —")
                        .font(.system(.caption, design: .serif))
                        .foregroundStyle(RosaryTheme.muted)
                        .tracking(2)
                        .textCase(.uppercase)

                    Text(mystery.name)
                        .font(.system(.title3, design: .serif))
                        .fontWeight(.bold)
                        .foregroundStyle(RosaryTheme.gold)

                    Text(mystery.meditation)
                        .font(.system(.footnote, design: .serif))
                        .foregroundStyle(RosaryTheme.cream.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                        .padding(.horizontal, 28)

                    Text(mystery.scripture)
                        .font(.system(.caption2, design: .serif))
                        .italic()
                        .foregroundStyle(RosaryTheme.muted)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.top, 2)
                }
                .padding(.top, 4)
            }

            Spacer()

            // Prayer name
            VStack(spacing: 6) {
                Text(state.currentStep.type.rawValue)
                    .font(.system(.title2, design: .serif))
                    .fontWeight(.bold)
                    .foregroundStyle(RosaryTheme.cream)

                if let hm = state.currentStep.hailMaryIndex {
                    Text("\(hm) of \(state.currentStep.decade != nil ? 10 : 3)")
                        .font(.system(.caption, design: .serif))
                        .foregroundStyle(RosaryTheme.muted)
                }
            }

            // Prayer text
            ScrollView {
                Text(state.prayerText)
                    .font(.system(.body, design: .serif))
                    .foregroundStyle(RosaryTheme.cream.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.horizontal, 28)
            }
            .frame(maxHeight: 200)

            Spacer()

            // Bead progress
            BeadProgressView(state: state)

            // Tap to advance
            Button(action: advanceBead) {
                Text("Continue")
                    .font(.system(.headline, design: .serif))
                    .foregroundStyle(RosaryTheme.darkBg)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RosaryTheme.gold, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: RosaryTheme.gold.opacity(0.3), radius: 8, y: 4)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 16)
        }
        .padding(.top, 8)
    }

    // MARK: - Completion

    private var completionView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 72))
                .foregroundStyle(RosaryTheme.gold)
                .shadow(color: RosaryTheme.gold.opacity(0.4), radius: 16)

            Text("Rosary Complete")
                .font(.system(.title, design: .serif))
                .fontWeight(.bold)
                .foregroundStyle(RosaryTheme.cream)

            Text("The \(state.mysterySet.rawValue) Mysteries")
                .font(.system(.subheadline, design: .serif))
                .foregroundStyle(RosaryTheme.muted)

            Text("✙")
                .font(.title)
                .foregroundStyle(RosaryTheme.gold.opacity(0.5))

            Spacer()

            Button(action: { dismiss() }) {
                Text("Done")
                    .font(.system(.headline, design: .serif))
                    .foregroundStyle(RosaryTheme.darkBg)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RosaryTheme.gold, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
    }
}

#Preview { NavigationStack { RosaryView(mysterySet: .joyful) } }
