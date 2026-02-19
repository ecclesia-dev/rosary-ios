import Foundation

// MARK: - Mystery Sets

enum MysterySet: String, CaseIterable, Identifiable {
    case joyful = "Joyful"
    case sorrowful = "Sorrowful"
    case glorious = "Glorious"

    var id: String { rawValue }

    var mysteries: [Mystery] {
        switch self {
        case .joyful: return Mystery.joyful
        case .sorrowful: return Mystery.sorrowful
        case .glorious: return Mystery.glorious
        }
    }

    var icon: String {
        switch self {
        case .joyful: return "sun.max.fill"
        case .sorrowful: return "cross.fill"
        case .glorious: return "crown.fill"
        }
    }

    /// Traditional day assignments: Mon/Thu=Joyful, Tue/Fri=Sorrowful, Wed/Sat/Sun=Glorious
    static func suggestedToday() -> MysterySet {
        let weekday = Calendar.current.component(.weekday, from: Date())
        switch weekday {
        case 1: return .glorious  // Sunday
        case 2: return .joyful    // Monday
        case 3: return .sorrowful // Tuesday
        case 4: return .glorious  // Wednesday
        case 5: return .joyful    // Thursday
        case 6: return .sorrowful // Friday
        case 7: return .glorious  // Saturday
        default: return .joyful
        }
    }
}

struct Mystery: Identifiable {
    let id = UUID()
    let name: String
    let meditation: String

    static let joyful: [Mystery] = [
        Mystery(name: "The Annunciation", meditation: "The angel Gabriel announces to Mary that she will bear the Son of God."),
        Mystery(name: "The Visitation", meditation: "Mary visits her cousin Elizabeth, who is pregnant with John the Baptist."),
        Mystery(name: "The Nativity", meditation: "Jesus is born in a stable in Bethlehem."),
        Mystery(name: "The Presentation", meditation: "Mary and Joseph present the infant Jesus in the Temple."),
        Mystery(name: "Finding in the Temple", meditation: "The child Jesus is found teaching the elders in the Temple."),
    ]

    static let sorrowful: [Mystery] = [
        Mystery(name: "Agony in the Garden", meditation: "Jesus prays in the Garden of Gethsemane, sweating blood."),
        Mystery(name: "Scourging at the Pillar", meditation: "Jesus is tied to a pillar and scourged."),
        Mystery(name: "Crowning with Thorns", meditation: "Soldiers place a crown of thorns on the head of Jesus."),
        Mystery(name: "Carrying the Cross", meditation: "Jesus carries His cross to Calvary."),
        Mystery(name: "The Crucifixion", meditation: "Jesus is nailed to the cross and dies for our salvation."),
    ]

    static let glorious: [Mystery] = [
        Mystery(name: "The Resurrection", meditation: "Jesus rises from the dead on the third day."),
        Mystery(name: "The Ascension", meditation: "Jesus ascends into heaven forty days after His resurrection."),
        Mystery(name: "Descent of the Holy Spirit", meditation: "The Holy Spirit descends upon the Apostles at Pentecost."),
        Mystery(name: "Assumption of Mary", meditation: "The Blessed Virgin Mary is assumed body and soul into heaven."),
        Mystery(name: "Coronation of Mary", meditation: "Mary is crowned Queen of Heaven and Earth."),
    ]

    // Traditional 15-mystery Rosary only — no Luminous mysteries
}
