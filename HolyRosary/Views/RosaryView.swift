import SwiftUI

struct RosaryView: View {
    @State private var state: RosaryState
    @Environment(\.dismiss) private var dismiss

    private let gold = Color(red: 0.85, green: 0.70, blue: 0.30)

    init(mysterySet: MysterySet) {
        _state = State(initialValue: RosaryState(mysterySet: mysterySet))
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

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
                    .foregroundStyle(gold)
                    .fontWeight(.semibold)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(state.useLatin ? "EN" : "LA") {
                    state.useLatin.toggle()
                }
                .foregroundStyle(gold)
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Prayer View

    private var prayerView: some View {
        VStack(spacing: 20) {
            // Mystery info
            if let mystery = state.currentMystery {
                VStack(spacing: 6) {
                    Text("Decade \(state.currentStep.decade ?? 0)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(mystery.name)
                        .font(.title3.bold())
                        .foregroundStyle(gold)
                    Text(mystery.meditation)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
            }

            Spacer()

            // Prayer name
            Text(state.currentStep.type.rawValue)
                .font(.title2.bold())
                .foregroundStyle(.white)

            if let hm = state.currentStep.hailMaryIndex {
                Text("\(hm) of \(state.currentStep.decade != nil ? 10 : 3)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // Prayer text
            ScrollView {
                Text(state.prayerText)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            .frame(maxHeight: 220)

            Spacer()

            // Bead progress
            BeadProgressView(state: state, gold: gold)

            // Tap to advance
            Button {
                let gen = UIImpactFeedbackGenerator(style: .medium)
                gen.impactOccurred()
                withAnimation(.easeInOut(duration: 0.2)) {
                    state.advance()
                }
                if state.isComplete {
                    RosaryTracker.record(mysterySet: state.mysterySet)
                }
            } label: {
                Text("Tap to Continue")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(gold)
                    .cornerRadius(14)
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
                .font(.system(size: 80))
                .foregroundStyle(gold)
            Text("Rosary Complete")
                .font(.title.bold())
                .foregroundStyle(.white)
            Text("The \(state.mysterySet.rawValue) Mysteries")
                .foregroundStyle(.secondary)
            Spacer()
            Button("Done") { dismiss() }
                .font(.headline)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(gold)
                .cornerRadius(14)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
        }
    }
}

#Preview { NavigationStack { RosaryView(mysterySet: .joyful) } }
