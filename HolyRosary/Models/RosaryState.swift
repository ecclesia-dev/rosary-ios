import Foundation
import SwiftUI

// MARK: - Bead / Prayer Step

enum BeadType: String {
    case signOfCross = "Sign of the Cross"
    case creed = "Apostles' Creed"
    case ourFather = "Our Father"
    case hailMary = "Hail Mary"
    case gloryBe = "Glory Be"
    case fatimaPrayer = "Fatima Prayer"
    case hailHolyQueen = "Hail, Holy Queen"
}

struct BeadStep: Equatable {
    let type: BeadType
    let decade: Int?        // 1-5, nil for intro/closing
    let hailMaryIndex: Int? // 1-10 within a decade

    static func == (lhs: BeadStep, rhs: BeadStep) -> Bool {
        lhs.type == rhs.type && lhs.decade == rhs.decade && lhs.hailMaryIndex == rhs.hailMaryIndex
    }
}

// MARK: - Rosary State Machine

@Observable
final class RosaryState {
    let mysterySet: MysterySet
    var useLatin = false
    private(set) var currentIndex = 0
    private(set) var steps: [BeadStep] = []
    var isComplete: Bool { currentIndex >= steps.count }

    init(mysterySet: MysterySet) {
        self.mysterySet = mysterySet
        self.steps = Self.buildSteps()
    }

    var currentStep: BeadStep { steps[min(currentIndex, steps.count - 1)] }
    var totalBeads: Int { steps.count }
    var progress: Double { Double(currentIndex) / Double(steps.count) }

    var currentMystery: Mystery? {
        guard let decade = currentStep.decade,
              decade >= 1, decade <= 5 else { return nil }
        return mysterySet.mysteries[decade - 1]
    }

    /// Returns true if this is the first bead of a new decade (the Our Father)
    var isNewDecade: Bool {
        currentStep.type == .ourFather && currentStep.decade != nil
    }

    var prayerText: String {
        let step = currentStep
        if useLatin {
            switch step.type {
            case .signOfCross: return Prayers.signOfTheCrossLA
            case .creed: return Prayers.creedLA
            case .ourFather: return Prayers.ourFatherLA
            case .hailMary: return Prayers.hailMaryLA
            case .gloryBe: return Prayers.gloryBeLA
            case .fatimaPrayer: return Prayers.fatimaPrayerLA
            case .hailHolyQueen: return Prayers.hailHolyQueenLA
            }
        } else {
            switch step.type {
            case .signOfCross: return Prayers.signOfTheCrossEN
            case .creed: return Prayers.creedEN
            case .ourFather: return Prayers.ourFatherEN
            case .hailMary: return Prayers.hailMaryEN
            case .gloryBe: return Prayers.gloryBeEN
            case .fatimaPrayer: return Prayers.fatimaPrayerEN
            case .hailHolyQueen: return Prayers.hailHolyQueenEN
            }
        }
    }

    func advance() {
        if currentIndex < steps.count {
            currentIndex += 1
        }
    }

    func goBack() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }

    // Build the full sequence:
    // Sign of Cross, Creed, OF, 3HM, GB,
    // [5× (OF, 10HM, GB, Fatima Prayer)],
    // Hail Holy Queen, Sign of Cross
    private static func buildSteps() -> [BeadStep] {
        var s: [BeadStep] = []

        // Opening
        s.append(BeadStep(type: .signOfCross, decade: nil, hailMaryIndex: nil))
        s.append(BeadStep(type: .creed, decade: nil, hailMaryIndex: nil))
        s.append(BeadStep(type: .ourFather, decade: nil, hailMaryIndex: nil))
        for i in 1...3 {
            s.append(BeadStep(type: .hailMary, decade: nil, hailMaryIndex: i))
        }
        s.append(BeadStep(type: .gloryBe, decade: nil, hailMaryIndex: nil))

        // Five decades
        for decade in 1...5 {
            s.append(BeadStep(type: .ourFather, decade: decade, hailMaryIndex: nil))
            for hm in 1...10 {
                s.append(BeadStep(type: .hailMary, decade: decade, hailMaryIndex: hm))
            }
            s.append(BeadStep(type: .gloryBe, decade: decade, hailMaryIndex: nil))
            s.append(BeadStep(type: .fatimaPrayer, decade: decade, hailMaryIndex: nil))
        }

        // Closing
        s.append(BeadStep(type: .hailHolyQueen, decade: nil, hailMaryIndex: nil))
        s.append(BeadStep(type: .signOfCross, decade: nil, hailMaryIndex: nil))

        return s
    }
}
