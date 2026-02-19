import Foundation

// MARK: - Completed Rosary Tracking (UserDefaults)

struct RosaryTracker {
    private static let key = "completedRosaries"

    struct Entry: Codable, Identifiable {
        var id: Date { date }
        let date: Date
        let mysterySet: String
    }

    static func record(mysterySet: MysterySet) {
        var entries = load()
        entries.append(Entry(date: Date(), mysterySet: mysterySet.rawValue))
        save(entries)
    }

    static func todayCount() -> Int {
        let cal = Calendar.current
        return load().filter { cal.isDateInToday($0.date) }.count
    }

    static func totalCount() -> Int { load().count }

    static func load() -> [Entry] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let entries = try? JSONDecoder().decode([Entry].self, from: data)
        else { return [] }
        return entries
    }

    private static func save(_ entries: [Entry]) {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
