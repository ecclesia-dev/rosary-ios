import SwiftUI

struct BeadProgressView: View {
    let state: RosaryState

    // Layout constants
    private let beadSize: CGFloat = 22
    private let largeBeadSize: CGFloat = 30
    private let currentBeadSize: CGFloat = 34
    private let spacing: CGFloat = 6

    var body: some View {
        VStack(spacing: 14) {
            // Counter
            Text("\(state.currentIndex + 1) / \(state.totalBeads)")
                .font(.system(.title3, design: .serif))
                .fontWeight(.semibold)
                .foregroundStyle(RosaryTheme.gold)

            if let decade = state.currentStep.decade {
                decadeRosary(decade: decade)
            } else {
                introRosary
            }
        }
    }

    // MARK: - Decade Rosary (Our Father + 10 Hail Marys + Glory Be)

    private func decadeRosary(decade: Int) -> some View {
        let decadeStart = 7 + (decade - 1) * 13

        return VStack(spacing: 12) {
            // Top row: beads 6-10
            HStack(spacing: spacing) {
                ForEach(6...10, id: \.self) { i in
                    rosaryBead(
                        filled: state.currentIndex >= decadeStart + i,
                        isCurrent: state.currentIndex == decadeStart + i,
                        isLarge: false
                    )
                }
            }

            // Middle row: bead 5, spacer, Glory Be
            HStack {
                rosaryBead(
                    filled: state.currentIndex >= decadeStart + 5,
                    isCurrent: state.currentIndex == decadeStart + 5,
                    isLarge: false
                )
                Spacer()
                rosaryBead(
                    filled: state.currentIndex >= decadeStart + 11,
                    isCurrent: state.currentIndex == decadeStart + 11,
                    isLarge: true
                )
            }
            .padding(.horizontal, 16)

            // Bottom rows: beads 4-1
            HStack {
                rosaryBead(
                    filled: state.currentIndex >= decadeStart + 4,
                    isCurrent: state.currentIndex == decadeStart + 4,
                    isLarge: false
                )
                Spacer()
            }
            .padding(.horizontal, 16)

            HStack {
                rosaryBead(
                    filled: state.currentIndex >= decadeStart + 3,
                    isCurrent: state.currentIndex == decadeStart + 3,
                    isLarge: false
                )
                Spacer()
            }
            .padding(.horizontal, 16)

            HStack {
                rosaryBead(
                    filled: state.currentIndex >= decadeStart + 2,
                    isCurrent: state.currentIndex == decadeStart + 2,
                    isLarge: false
                )
                Spacer()
            }
            .padding(.horizontal, 16)

            HStack {
                rosaryBead(
                    filled: state.currentIndex >= decadeStart + 1,
                    isCurrent: state.currentIndex == decadeStart + 1,
                    isLarge: false
                )
                Spacer()
            }
            .padding(.horizontal, 16)

            // Our Father bead at bottom center
            rosaryBead(
                filled: state.currentIndex >= decadeStart,
                isCurrent: state.currentIndex == decadeStart,
                isLarge: true
            )
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Intro beads (crucifix area)

    private var introRosary: some View {
        VStack(spacing: spacing + 2) {
            // Glory Be at top
            rosaryBead(filled: state.currentIndex >= 6, isCurrent: state.currentIndex == 6, isLarge: true)

            // 3 Hail Marys
            ForEach([5, 4, 3], id: \.self) { i in
                rosaryBead(filled: state.currentIndex >= i, isCurrent: state.currentIndex == i, isLarge: false)
            }

            // Our Father
            rosaryBead(filled: state.currentIndex >= 2, isCurrent: state.currentIndex == 2, isLarge: true)

            // Creed
            rosaryBead(filled: state.currentIndex >= 1, isCurrent: state.currentIndex == 1, isLarge: true)

            // Cross
            Image(systemName: "cross.fill")
                .font(.system(size: 28))
                .foregroundStyle(state.currentIndex >= 0 ? RosaryTheme.gold : RosaryTheme.cream.opacity(0.15))
                .shadow(color: state.currentIndex >= 0 ? RosaryTheme.gold.opacity(0.4) : .clear, radius: 4)
        }
    }

    // MARK: - Single Bead

    private func rosaryBead(filled: Bool, isCurrent: Bool, isLarge: Bool) -> some View {
        let size: CGFloat = isCurrent ? currentBeadSize : (isLarge ? largeBeadSize : beadSize)

        return ZStack {
            // Outer glow for current bead
            if isCurrent {
                Circle()
                    .fill(RosaryTheme.gold.opacity(0.25))
                    .frame(width: size + 12, height: size + 12)

                Circle()
                    .strokeBorder(RosaryTheme.gold.opacity(0.6), lineWidth: 2)
                    .frame(width: size + 12, height: size + 12)
            }

            // Bead body with gradient for 3D effect
            Circle()
                .fill(
                    filled
                        ? RadialGradient(
                            colors: [
                                RosaryTheme.gold.opacity(1.0),
                                RosaryTheme.gold.opacity(0.7),
                                Color(red: 0.6, green: 0.45, blue: 0.15)
                            ],
                            center: .init(x: 0.35, y: 0.3),
                            startRadius: 0,
                            endRadius: size * 0.6
                        )
                        : RadialGradient(
                            colors: [
                                RosaryTheme.cream.opacity(0.18),
                                RosaryTheme.cream.opacity(0.06)
                            ],
                            center: .init(x: 0.35, y: 0.3),
                            startRadius: 0,
                            endRadius: size * 0.6
                        )
                )
                .frame(width: size, height: size)
                .shadow(color: filled ? RosaryTheme.gold.opacity(0.35) : .clear, radius: 4, y: 2)

            // Highlight spot for 3D look
            if filled {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.white.opacity(0.5), Color.clear],
                            center: .init(x: 0.3, y: 0.25),
                            startRadius: 0,
                            endRadius: size * 0.35
                        )
                    )
                    .frame(width: size * 0.6, height: size * 0.6)
                    .offset(x: -size * 0.12, y: -size * 0.15)
            }
        }
        .frame(width: currentBeadSize + 12, height: currentBeadSize + 12)
        .animation(.easeInOut(duration: 0.3), value: filled)
        .animation(.easeInOut(duration: 0.3), value: isCurrent)
    }
}
