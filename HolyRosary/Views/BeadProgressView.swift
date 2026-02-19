import SwiftUI

struct BeadProgressView: View {
    let state: RosaryState

    var body: some View {
        VStack(spacing: 10) {
            // Overall progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(RosaryTheme.cream.opacity(0.08))
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [RosaryTheme.gold, RosaryTheme.gold.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * state.progress)
                        .animation(.easeInOut(duration: 0.35), value: state.progress)
                }
            }
            .frame(height: 5)
            .padding(.horizontal, 32)

            // Decade dots
            if let decade = state.currentStep.decade {
                decadeBeads(decade: decade)
            } else {
                introBeads
            }

            Text("\(state.currentIndex + 1) of \(state.totalBeads)")
                .font(.system(.caption2, design: .serif))
                .foregroundStyle(RosaryTheme.muted)
        }
    }

    // 10 dots for current decade
    private func decadeBeads(decade: Int) -> some View {
        HStack(spacing: 4) {
            // Our Father bead (larger)
            beadDot(filled: beadFilled(decade: decade, position: 0), large: true)

            // 10 Hail Mary beads
            ForEach(1...10, id: \.self) { i in
                beadDot(filled: beadFilled(decade: decade, position: i), large: false)
            }

            // Glory Be bead (larger)
            beadDot(filled: beadFilled(decade: decade, position: 11), large: true)
        }
    }

    private func beadFilled(decade: Int, position: Int) -> Bool {
        // Opening: SignOfCross + Creed + OF + 3HM + GB = 7 beads (indices 0-6)
        // Each decade: OF + 10HM + GB + Fatima = 13 beads
        let decadeStart = 7 + (decade - 1) * 13
        let beadIndex = decadeStart + position
        return state.currentIndex >= beadIndex
    }

    // Intro beads: Sign of Cross, Creed, OF, 3 HM, GB
    private var introBeads: some View {
        HStack(spacing: 5) {
            ForEach(0..<7, id: \.self) { i in
                let large = (i == 0 || i == 1 || i == 2 || i == 6)
                beadDot(filled: state.currentIndex >= i, large: large)
            }
        }
    }

    private func beadDot(filled: Bool, large: Bool) -> some View {
        Circle()
            .fill(filled ? RosaryTheme.gold : RosaryTheme.cream.opacity(0.12))
            .frame(width: large ? 10 : 7, height: large ? 10 : 7)
            .shadow(color: filled ? RosaryTheme.gold.opacity(0.3) : .clear, radius: 3)
            .animation(.easeInOut(duration: 0.2), value: filled)
    }
}
