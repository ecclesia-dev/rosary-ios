import SwiftUI

// MARK: - Novena List View

struct NovenaListView: View {
    @State private var activeNovenas: [ActiveNovena] = NovenaTracker.activeNovenas()
    @State private var showingStartSheet = false
    @State private var selectedNovena: Novena?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Active Novenas
                    if !activeNovenas.filter({ !$0.isComplete }).isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Active Novenas")
                                .font(.headline)
                                .foregroundColor(Theme.gold)
                                .padding(.horizontal)

                            ForEach(activeNovenas.filter { !$0.isComplete }) { active in
                                if let novena = NovenaLibrary.novena(forId: active.novenaId) {
                                    ActiveNovenaCard(active: active, novena: novena) {
                                        refreshActive()
                                    }
                                }
                            }
                        }
                    }

                    // Completed Novenas
                    if !activeNovenas.filter({ $0.isComplete }).isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Completed")
                                    .font(.headline)
                                    .foregroundColor(Theme.gold)
                                Spacer()
                                Button("Clear") {
                                    NovenaTracker.removeCompleted()
                                    refreshActive()
                                }
                                .font(.caption)
                                .foregroundColor(Theme.textMuted)
                            }
                            .padding(.horizontal)

                            ForEach(activeNovenas.filter { $0.isComplete }) { active in
                                if let novena = NovenaLibrary.novena(forId: active.novenaId) {
                                    CompletedNovenaCard(novena: novena)
                                }
                            }
                        }
                    }

                    // Browse Novenas
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Start a Novena")
                            .font(.headline)
                            .foregroundColor(Theme.gold)
                            .padding(.horizontal)

                        ForEach(NovenaLibrary.allNovenas) { novena in
                            NovenaCard(novena: novena) {
                                selectedNovena = novena
                                showingStartSheet = true
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .background(Theme.background)
            .navigationTitle("Novenas")
            .sheet(isPresented: $showingStartSheet) {
                if let novena = selectedNovena {
                    StartNovenaSheet(novena: novena) {
                        refreshActive()
                        showingStartSheet = false
                    }
                }
            }
            .onAppear { refreshActive() }
        }
    }

    private func refreshActive() {
        activeNovenas = NovenaTracker.activeNovenas()
    }
}

// MARK: - Active Novena Card

struct ActiveNovenaCard: View {
    let active: ActiveNovena
    let novena: Novena
    let onComplete: () -> Void
    @State private var showingPrayer = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: novena.icon)
                    .foregroundColor(Theme.gold)
                    .font(.title2)
                VStack(alignment: .leading) {
                    Text(novena.name)
                        .font(.headline)
                        .foregroundColor(Theme.textPrimary)
                    Text("Day \(active.currentDay) of \(novena.totalDays)")
                        .font(.subheadline)
                        .foregroundColor(Theme.gold)
                }
                Spacer()
                if !active.dayCompletedToday {
                    Button("Pray") {
                        showingPrayer = true
                    }
                    .font(.headline)
                    .foregroundColor(Theme.background)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Theme.gold)
                    .cornerRadius(8)
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                }
            }

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 6)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Theme.gold)
                        .frame(width: geo.size.width * active.progress, height: 6)
                }
            }
            .frame(height: 6)

            if !active.intention.isEmpty {
                Text("Intention: \(active.intention)")
                    .font(.caption)
                    .foregroundColor(Theme.textMuted)
                    .italic()
            }
        }
        .padding()
        .background(Theme.cardBackground)
        .cornerRadius(12)
        .padding(.horizontal)
        .sheet(isPresented: $showingPrayer) {
            if active.currentDay <= novena.totalDays,
               let dayPrayer = novena.dailyPrayers.first(where: { $0.dayNumber == active.currentDay }) {
                NovenaPrayerView(novena: novena, day: dayPrayer) {
                    NovenaTracker.completeDay(novenaId: novena.id, day: active.currentDay)
                    onComplete()
                    showingPrayer = false
                }
            }
        }
    }
}

// MARK: - Completed Card

struct CompletedNovenaCard: View {
    let novena: Novena

    var body: some View {
        HStack {
            Image(systemName: novena.icon)
                .foregroundColor(.green)
            Text(novena.name)
                .foregroundColor(Theme.textPrimary)
            Spacer()
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.green)
        }
        .padding()
        .background(Theme.cardBackground)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// MARK: - Browse Card

struct NovenaCard: View {
    let novena: Novena
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                Image(systemName: novena.icon)
                    .foregroundColor(Theme.gold)
                    .font(.title2)
                    .frame(width: 40)
                VStack(alignment: .leading, spacing: 4) {
                    Text(novena.name)
                        .font(.headline)
                        .foregroundColor(Theme.textPrimary)
                    Text("\(novena.totalDays) days · \(novena.patron)")
                        .font(.caption)
                        .foregroundColor(Theme.textMuted)
                    Text(novena.description)
                        .font(.caption2)
                        .foregroundColor(Theme.textMuted)
                        .lineLimit(2)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Theme.textMuted)
            }
            .padding()
            .background(Theme.cardBackground)
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

// MARK: - Start Novena Sheet

struct StartNovenaSheet: View {
    let novena: Novena
    let onStart: () -> Void
    @State private var intention = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: novena.icon)
                    .font(.system(size: 50))
                    .foregroundColor(Theme.gold)

                Text(novena.name)
                    .font(.title2.bold())
                    .foregroundColor(Theme.textPrimary)

                Text(novena.description)
                    .font(.body)
                    .foregroundColor(Theme.textMuted)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("\(novena.totalDays) days")
                    .font(.headline)
                    .foregroundColor(Theme.gold)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Intention (optional)")
                        .font(.caption)
                        .foregroundColor(Theme.textMuted)
                    TextField("What are you praying for?", text: $intention)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)

                Spacer()

                Button(action: {
                    NovenaTracker.startNovena(id: novena.id, intention: intention)
                    onStart()
                }) {
                    Text("Begin Novena")
                        .font(.headline)
                        .foregroundColor(Theme.background)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.gold)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.top, 30)
            .background(Theme.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(Theme.gold)
                }
            }
        }
    }
}

// MARK: - Prayer View

struct NovenaPrayerView: View {
    let novena: Novena
    let day: Novena.NovenaDay
    let onComplete: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text(novena.name)
                        .font(.headline)
                        .foregroundColor(Theme.gold)

                    Text(day.title)
                        .font(.title3.bold())
                        .foregroundColor(Theme.textPrimary)

                    Text(day.prayerText)
                        .font(.body)
                        .foregroundColor(Theme.textPrimary)
                        .lineSpacing(6)
                        .padding(.horizontal)

                    Spacer(minLength: 30)

                    Button(action: onComplete) {
                        Text("Mark Day Complete")
                            .font(.headline)
                            .foregroundColor(Theme.background)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.gold)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 20)
            }
            .background(Theme.background)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundColor(Theme.gold)
                }
            }
        }
    }
}
