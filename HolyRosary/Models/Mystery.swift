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

    var subtitle: String {
        switch self {
        case .joyful: return "Monday & Saturday"
        case .sorrowful: return "Tuesday & Friday"
        case .glorious: return "Wednesday, Thursday & Sunday"
        }
    }

    /// Traditional day assignments
    /// Mon & Sat = Joyful, Tue & Fri = Sorrowful, Wed & Thu & Sun = Glorious
    static func suggestedToday() -> MysterySet {
        let weekday = Calendar.current.component(.weekday, from: Date())
        switch weekday {
        case 1: return .glorious  // Sunday
        case 2: return .joyful    // Monday
        case 3: return .sorrowful // Tuesday
        case 4: return .glorious  // Wednesday
        case 5: return .glorious  // Thursday
        case 6: return .sorrowful // Friday
        case 7: return .joyful    // Saturday
        default: return .joyful
        }
    }

    static func dayName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: Date())
    }
}

struct Mystery: Identifiable {
    let id = UUID()
    let name: String
    let meditation: String
    let scripture: String  // Douay-Rheims reference

    // MARK: - Joyful Mysteries

    static let joyful: [Mystery] = [
        Mystery(
            name: "The Annunciation",
            meditation: "The Angel Gabriel is sent by God to the Virgin Mary, announcing that she shall conceive by the Holy Ghost and bring forth the Saviour of the world.",
            scripture: "And the angel being come in, said unto her: Hail, full of grace, the Lord is with thee: blessed art thou among women. — Luke 1:28"
        ),
        Mystery(
            name: "The Visitation",
            meditation: "The Blessed Virgin Mary, bearing the Christ Child within her, visits her cousin Elizabeth, who is with child. At Mary's greeting, the infant John leaps in Elizabeth's womb.",
            scripture: "And Elizabeth was filled with the Holy Ghost: and she cried out with a loud voice, and said: Blessed art thou among women, and blessed is the fruit of thy womb. — Luke 1:41–42"
        ),
        Mystery(
            name: "The Nativity",
            meditation: "Our Lord Jesus Christ is born in a stable at Bethlehem, laid in a manger, and adored by shepherds and angels.",
            scripture: "And she brought forth her firstborn son, and wrapped him up in swaddling clothes, and laid him in a manger; because there was no room for them in the inn. — Luke 2:7"
        ),
        Mystery(
            name: "The Presentation in the Temple",
            meditation: "The Blessed Virgin Mary and Saint Joseph present the Child Jesus in the Temple, where holy Simeon receives Him in his arms.",
            scripture: "Now thou dost dismiss thy servant, O Lord, according to thy word in peace; because my eyes have seen thy salvation. — Luke 2:29–30"
        ),
        Mystery(
            name: "The Finding in the Temple",
            meditation: "After three days of sorrow, Mary and Joseph find the Child Jesus in the Temple, sitting among the doctors, hearing them and asking them questions.",
            scripture: "And he said to them: How is it that you sought me? Did you not know, that I must be about my father's business? — Luke 2:49"
        ),
    ]

    // MARK: - Sorrowful Mysteries

    static let sorrowful: [Mystery] = [
        Mystery(
            name: "The Agony in the Garden",
            meditation: "Jesus prays in the Garden of Gethsemane, and His sweat becomes as drops of blood falling upon the ground. He accepts the Father's will.",
            scripture: "And being in an agony, he prayed the longer. And his sweat became as drops of blood, trickling down upon the ground. — Luke 22:43–44"
        ),
        Mystery(
            name: "The Scourging at the Pillar",
            meditation: "Our Lord is stripped of His garments, bound to a pillar, and cruelly scourged by the Roman soldiers.",
            scripture: "Pilate therefore took Jesus, and scourged him. — John 19:1"
        ),
        Mystery(
            name: "The Crowning with Thorns",
            meditation: "The soldiers weave a crown of sharp thorns and press it upon the sacred head of Jesus, mocking Him as King.",
            scripture: "And platting a crown of thorns, they put it upon his head, and a reed in his right hand. And bowing the knee before him, they mocked him, saying: Hail, king of the Jews. — Matthew 27:29"
        ),
        Mystery(
            name: "The Carrying of the Cross",
            meditation: "Jesus, weakened and bleeding, carries His heavy cross through the streets of Jerusalem to the hill of Calvary.",
            scripture: "And bearing his own cross, he went forth to that place which is called Calvary, but in Hebrew Golgotha. — John 19:17"
        ),
        Mystery(
            name: "The Crucifixion and Death",
            meditation: "Our Lord Jesus Christ is nailed to the cross and dies after three hours of agony, offering His life for the redemption of the world.",
            scripture: "And Jesus crying with a loud voice, said: Father, into thy hands I commend my spirit. And saying this, he gave up the ghost. — Luke 23:46"
        ),
    ]

    // MARK: - Glorious Mysteries

    static let glorious: [Mystery] = [
        Mystery(
            name: "The Resurrection",
            meditation: "On the third day, Our Lord Jesus Christ rises gloriously from the dead, conquering sin and death forever.",
            scripture: "He is not here, for he is risen, as he said. Come, and see the place where the Lord was laid. — Matthew 28:6"
        ),
        Mystery(
            name: "The Ascension",
            meditation: "Forty days after the Resurrection, Our Lord ascends into heaven in the presence of His Mother and His disciples.",
            scripture: "And the Lord Jesus, after he had spoken to them, was taken up into heaven, and sitteth on the right hand of God. — Mark 16:19"
        ),
        Mystery(
            name: "The Descent of the Holy Ghost",
            meditation: "The Holy Ghost descends upon the Blessed Virgin Mary and the Apostles in the form of tongues of fire, ten days after the Ascension.",
            scripture: "And they were all filled with the Holy Ghost, and they began to speak with divers tongues, according as the Holy Ghost gave them to speak. — Acts 2:4"
        ),
        Mystery(
            name: "The Assumption of Mary",
            meditation: "The Blessed Virgin Mary, having completed the course of her earthly life, is assumed body and soul into the glory of heaven.",
            scripture: "Thou art the glory of Jerusalem, thou art the joy of Israel, thou art the honour of our people. — Judith 15:10"
        ),
        Mystery(
            name: "The Coronation of the Blessed Virgin Mary",
            meditation: "The Blessed Virgin Mary is crowned Queen of Heaven and Earth, Queen of Angels and Saints, by her Divine Son.",
            scripture: "And a great sign appeared in heaven: a woman clothed with the sun, and the moon under her feet, and on her head a crown of twelve stars. — Apocalypse 12:1"
        ),
    ]

}
