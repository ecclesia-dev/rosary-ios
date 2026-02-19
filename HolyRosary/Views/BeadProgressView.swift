import SwiftUI

struct BeadProgressView: View {
    let state: RosaryState
    let gold: Color

    var body: some View {
        VStack(spacing: 8) {
            // Overall progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.1))
                    Capsule()
                        .fill(gold)
                        .frame(width: geo.size.width * state.progress)
                        .animation(.easeInOut(duration: 0.3), value: state.progress)
                }
            }
            .frame(height: 6)
            .padding(.horizontal, 32)

            // Decade dots
            if let decade = state.currentStep.decade {
                decadeBeads(decade: decade)
            } else {
                introBeads
            }

            Text("\(state.currentIndex + 1) / \(state.totalBeads)")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    // 10 dots for current decade + OF + GB
    private func decadeBeads(decade: Int) -> some View {
        HStack(spacing: 4) {
            // Our Father bead (larger)
            Circle()
                .fill(beadFilled(decade: decade, position: 0) ? gold : Color.white.opacity(0.15))
                .frame(width: 10, height: 10)

            // 10 Hail Mary beads
            ForEach(1...10, id: \.self) { i in
                Circle()
                    .fill(beadFilled(decade: decade, position: i) ? gold : Color.white.opacity(0.15))
                    .frame(width: 7, height: 7)
            }

            // Glory Be bead (larger)
            Circle()
                .fill(beadFilled(decade: decade, position: 11) ? gold : Color.white.opacity(0.15))
                .frame(width: 10, height: 10)
        }
    }

    private func beadFilled(decade: Int, position: Int) -> Bool {
        // Find the index of the Our Father for this decade
        // Intro: 6 beads (0-5), then each decade is 12 beads
        let decadeStart = 6 + (decade - 1) * 12
        let beadIndex = decadeStart + position
        return state.currentIndex >= beadIndex
    }

    // Intro beads: Creed, OF, 3 HM, GB
    private var introBeads: some View {
        HStack(spacing: 5) {
            ForEach(0..<6, id: \.self) { i in
                Circle()
                    .fill(state.currentIndex >= i ? gold : Color.white.opacity(0.15))
                    .frame(width: i == 0 || i == 1 || i == 5 ? 10 : 7,
                           height: i == 0 || i == 1 || i == 5 ? 10 : 7)
            }
        }
    }
}
