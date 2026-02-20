import Foundation

// MARK: - Active Novena Tracking (UserDefaults)

struct ActiveNovena: Codable, Identifiable {
    var id: String { novenaId }
    let novenaId: String
    let startDate: Date
    var completedDays: [Int]  // Day numbers that have been completed
    var intention: String

    var currentDay: Int {
        let calendar = Calendar.current
        let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: startDate), to: calendar.startOfDay(for: Date())).day ?? 0
        return min(days + 1, totalDaysForNovena)
    }

    var totalDaysForNovena: Int {
        NovenaLibrary.novena(forId: novenaId)?.totalDays ?? 9
    }

    var isComplete: Bool {
        completedDays.count >= totalDaysForNovena
    }

    var progress: Double {
        Double(completedDays.count) / Double(totalDaysForNovena)
    }

    var dayCompletedToday: Bool {
        completedDays.contains(currentDay)
    }
}

struct NovenaTracker {
    private static let key = "activeNovenas"

    static func activeNovenas() -> [ActiveNovena] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let novenas = try? JSONDecoder().decode([ActiveNovena].self, from: data)
        else { return [] }
        return novenas
    }

    static func startNovena(id: String, intention: String) {
        var novenas = activeNovenas()
        // Don't allow duplicate active novenas of the same type
        novenas.removeAll { $0.novenaId == id && !$0.isComplete }
        let novena = ActiveNovena(
            novenaId: id,
            startDate: Date(),
            completedDays: [],
            intention: intention
        )
        novenas.append(novena)
        save(novenas)
    }

    static func completeDay(novenaId: String, day: Int) {
        var novenas = activeNovenas()
        if let index = novenas.firstIndex(where: { $0.novenaId == novenaId && !$0.isComplete }) {
            if !novenas[index].completedDays.contains(day) {
                novenas[index].completedDays.append(day)
            }
            save(novenas)
        }
    }

    static func removeNovena(id: String) {
        var novenas = activeNovenas()
        novenas.removeAll { $0.novenaId == id }
        save(novenas)
    }

    static func removeCompleted() {
        var novenas = activeNovenas()
        novenas.removeAll { $0.isComplete }
        save(novenas)
    }

    private static func save(_ novenas: [ActiveNovena]) {
        if let data = try? JSONEncoder().encode(novenas) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
