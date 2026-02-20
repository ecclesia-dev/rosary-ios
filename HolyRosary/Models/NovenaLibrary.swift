import Foundation

// MARK: - Novena Library

struct NovenaLibrary {
    static let allNovenas: [Novena] = [
        FiftyFourDayRosaryNovena.novena,
        sacredHeart,
        miraculousMedal,
        stJoseph,
        stJude,
        stTherese,
        ourLadyPerpetualHelp,
    ]

    static func novena(forId id: String) -> Novena? {
        allNovenas.first { $0.id == id }
    }

    // MARK: - Sacred Heart Novena

    private static let sacredHeart = Novena(
        id: "sacred-heart",
        name: "Novena to the Sacred Heart",
        patron: "Sacred Heart of Jesus",
        description: "Nine days of prayer to the Sacred Heart of Jesus, seeking His mercy and love.",
        totalDays: 9,
        icon: "heart.fill",
        dailyPrayers: (1...9).map { day in
            Novena.NovenaDay(
                dayNumber: day,
                title: "Day \(day)",
                prayerText: """
                O my Jesus, Thou hast said: "Truly I say to you, ask and you shall receive, seek and you shall find, knock and it shall be opened to you." Behold, I knock, I seek, and I ask for the grace of (mention your intention).

                Our Father. Hail Mary. Glory Be.
                Sacred Heart of Jesus, I place all my trust in Thee.

                O my Jesus, Thou hast said: "Truly I say to you, if you ask anything of the Father in My name, He will give it to you." Behold, in Thy name, I ask the Father for the grace of (mention your intention).

                Our Father. Hail Mary. Glory Be.
                Sacred Heart of Jesus, I place all my trust in Thee.

                O my Jesus, Thou hast said: "Truly I say to you, heaven and earth shall pass away, but My words shall not pass away." Encouraged by Thy infallible words, I now ask for the grace of (mention your intention).

                Our Father. Hail Mary. Glory Be.
                Sacred Heart of Jesus, I place all my trust in Thee.

                O Sacred Heart of Jesus, for whom it is impossible not to have compassion on the afflicted, have pity on us miserable sinners, and grant us the grace which we ask of Thee, through the Sorrowful and Immaculate Heart of Mary, Thy tender Mother and ours.

                Hail, Holy Queen.
                St. Joseph, foster father of Jesus, pray for us.
                """
            )
        }
    )

    // MARK: - Miraculous Medal Novena

    private static let miraculousMedal = Novena(
        id: "miraculous-medal",
        name: "Miraculous Medal Novena",
        patron: "Blessed Virgin Mary",
        description: "Novena to Our Lady of the Miraculous Medal, asking for her powerful intercession.",
        totalDays: 9,
        icon: "star.fill",
        dailyPrayers: (1...9).map { day in
            Novena.NovenaDay(
                dayNumber: day,
                title: "Day \(day)",
                prayerText: """
                O Immaculate Virgin Mary, Mother of Our Lord Jesus and our Mother, penetrated with the most lively confidence in thy all-powerful and never-failing intercession, manifested so often through the Miraculous Medal, we thy loving and trustful children implore thee to obtain for us the graces and favors we ask during this novena, if they be beneficial to our immortal souls, and the souls for whom we pray.

                (Mention your intention)

                Thou knowest, O Mary, how often our souls have been the sanctuaries of thy Son, who hates iniquity. Obtain for us, then, a deep hatred of sin, and that purity of heart which will attach us to God alone, so that our every thought, word, and deed may tend to His greater glory. Obtain for us also a spirit of prayer and self-denial, that we may recover by penance what we have lost by sin, and at length attain to that blessed abode, where thou art the Queen of angels and of men. Amen.

                O Mary, conceived without sin, pray for us who have recourse to thee. (3 times)
                """
            )
        }
    )

    // MARK: - St. Joseph Novena

    private static let stJoseph = Novena(
        id: "st-joseph",
        name: "Novena to St. Joseph",
        patron: "St. Joseph",
        description: "Nine days of prayer to the foster father of Jesus, patron of workers, families, and the dying.",
        totalDays: 9,
        icon: "hammer.fill",
        dailyPrayers: (1...9).map { day in
            Novena.NovenaDay(
                dayNumber: day,
                title: "Day \(day)",
                prayerText: """
                O St. Joseph, whose protection is so great, so strong, so prompt before the throne of God, I place in thee all my interests and desires.

                O St. Joseph, do assist me by thy powerful intercession and obtain for me from thy Divine Son all spiritual blessings through Jesus Christ, Our Lord; so that having engaged here below thy heavenly power, I may offer my thanksgiving and homage to the most loving of Fathers.

                O St. Joseph, I never weary contemplating thee and Jesus asleep in thy arms. I dare not approach while He reposes near thy heart. Press Him in my name and kiss His fine head for me, and ask Him to return the kiss when I draw my dying breath.

                (Mention your intention)

                St. Joseph, patron of departing souls, pray for us. Amen.

                Our Father. Hail Mary. Glory Be.
                """
            )
        }
    )

    // MARK: - St. Jude Novena

    private static let stJude = Novena(
        id: "st-jude",
        name: "Novena to St. Jude",
        patron: "St. Jude Thaddeus",
        description: "Patron of hopeless causes and desperate situations. Turn to him when all seems lost.",
        totalDays: 9,
        icon: "flame.fill",
        dailyPrayers: (1...9).map { day in
            Novena.NovenaDay(
                dayNumber: day,
                title: "Day \(day)",
                prayerText: """
                Most holy apostle, St. Jude, faithful servant and friend of Jesus, the Church honors and invokes thee universally as the patron of hopeless cases, of things almost despaired of. Pray for me, I am so helpless and alone. Make use, I implore thee, of that particular privilege given to thee, to bring visible and speedy help where help is almost despaired of. Come to my assistance in this great need, that I may receive the consolation and help of heaven in all my necessities, tribulations, and sufferings, particularly:

                (Mention your intention)

                and that I may praise God with thee and all the elect forever. I promise, O blessed St. Jude, to be ever mindful of this great favor, to always honor thee as my special and powerful patron, and to gratefully encourage devotion to thee. Amen.

                Our Father. Hail Mary. Glory Be.
                """
            )
        }
    )

    // MARK: - St. Therese Novena

    private static let stTherese = Novena(
        id: "st-therese",
        name: "Novena to St. Thérèse",
        patron: "St. Thérèse of Lisieux",
        description: "The Little Flower promised to spend her heaven doing good upon earth. Ask her intercession.",
        totalDays: 9,
        icon: "leaf.fill",
        dailyPrayers: (1...9).map { day in
            Novena.NovenaDay(
                dayNumber: day,
                title: "Day \(day)",
                prayerText: """
                O Little Thérèse of the Child Jesus, please pick for me a rose from the heavenly gardens and send it to me as a message of love.

                O Little Flower of Jesus, ask God today to grant the favors I now place with confidence in thy hands:

                (Mention your intention)

                St. Thérèse, help me to always believe, as thou didst, in God's great love for me, so that I might imitate thy "Little Way" each day.

                Thou hast promised: "I will let fall from heaven a shower of roses." Send thy roses upon those who seek thy intercession. Amen.

                Our Father. Hail Mary. Glory Be.
                """
            )
        }
    )

    // MARK: - Our Lady of Perpetual Help

    private static let ourLadyPerpetualHelp = Novena(
        id: "perpetual-help",
        name: "Novena to Our Lady of Perpetual Help",
        patron: "Blessed Virgin Mary",
        description: "A beloved novena to Our Mother of Perpetual Help, seeking her unfailing assistance.",
        totalDays: 9,
        icon: "hands.sparkles.fill",
        dailyPrayers: (1...9).map { day in
            Novena.NovenaDay(
                dayNumber: day,
                title: "Day \(day)",
                prayerText: """
                O Mother of Perpetual Help, grant that I may ever invoke thy most powerful name, which is the safeguard of the living and the salvation of the dying.

                O purest Mary, O sweetest Mary, let thy name henceforth be ever on my lips. Delay not, O Blessed Lady, to help me whenever I call on thee, for in all my needs, in all my temptations, I shall never cease to call on thee, ever repeating thy sacred name, Mary, Mary.

                (Mention your intention)

                O what consolation, what sweetness, what confidence, what emotion fill my soul when I pronounce thy sacred name, or even only think of thee! I thank God for having given thee, for my good, so sweet, so powerful, so lovely a name. But I will not be content with merely pronouncing thy name; let my love for thee prompt me ever to hail thee, Mother of Perpetual Help.

                Our Father. Hail Mary. Glory Be.

                Mother of Perpetual Help, pray for us.
                """
            )
        }
    )
}
