import Foundation

// MARK: - Novena Model

struct Novena: Identifiable {
    let id: String
    let name: String
    let patron: String          // e.g. "Sacred Heart of Jesus"
    let description: String
    let totalDays: Int
    let icon: String            // SF Symbol
    let dailyPrayers: [NovenaDay]

    struct NovenaDay {
        let dayNumber: Int
        let title: String
        let prayerText: String
    }
}

// MARK: - 54-Day Rosary Novena

/// The 54-Day Rosary Novena is special: it's 27 days petition + 27 days thanksgiving.
/// Each "day" is a full Rosary with rotating mysteries: Joyful, Sorrowful, Glorious (repeating).
struct FiftyFourDayRosaryNovena {
    static let id = "54day-rosary"
    static let totalDays = 54

    /// Returns which mystery set to pray on a given day (1-54)
    static func mysterySet(forDay day: Int) -> MysterySet {
        // Days 1-3: Joyful, Sorrowful, Glorious, then repeat
        let index = (day - 1) % 3
        switch index {
        case 0: return .joyful
        case 1: return .sorrowful
        case 2: return .glorious
        default: return .joyful
        }
    }

    /// Whether the day is in the petition phase (days 1-27) or thanksgiving (28-54)
    static func phase(forDay day: Int) -> String {
        day <= 27 ? "Petition" : "Thanksgiving"
    }

    /// Which 3-day cycle within the current phase (1-9)
    static func cycleNumber(forDay day: Int) -> Int {
        let dayInPhase = day <= 27 ? day : day - 27
        return ((dayInPhase - 1) / 3) + 1
    }

    static let novena = Novena(
        id: id,
        name: "54-Day Rosary Novena",
        patron: "Blessed Virgin Mary",
        description: "The most powerful Rosary novena: 27 days of petition praying three sets of mysteries in rotation (Joyful, Sorrowful, Glorious), followed by 27 days of thanksgiving with the same rotation. Pray one full Rosary each day.",
        totalDays: totalDays,
        icon: "rosette",
        dailyPrayers: (1...54).map { day in
            let mysteries = mysterySet(forDay: day)
            let phase = phase(forDay: day)
            let cycle = cycleNumber(forDay: day)
            return Novena.NovenaDay(
                dayNumber: day,
                title: "Day \(day) — \(phase) (Cycle \(cycle)) — \(mysteries.rawValue) Mysteries",
                prayerText: """
                    \(phase.uppercased()) PHASE — Day \(day) of 54

                    Pray the complete Rosary using the \(mysteries.rawValue) Mysteries.

                    \(phase == "Petition" ? "Offer this Rosary for your intention, humbly petitioning Our Lady's intercession." : "Offer this Rosary in thanksgiving for graces received, whether your petition has been visibly answered or not. Trust in God's providence.")

                    Before beginning, pray:

                    Queen of the Holy Rosary, in this \(phase.lowercased()) novena I come to thee, confident in thy powerful intercession. Through the merits of thy Most Holy Rosary, I humbly ask thee to obtain for me \(phase == "Petition" ? "the grace I desire" : "the grace of gratitude and perseverance"). I ask this through Jesus Christ, thy Son, Our Lord. Amen.

                    Then pray the five decades of the \(mysteries.rawValue) Mysteries.

                    THE \(mysteries.rawValue.uppercased()) MYSTERIES:
                    \(mysteries.mysteries.enumerated().map { i, m in "\(i+1). \(m.name)" }.joined(separator: "\n"))
                    """
            )
        }
    )
}
