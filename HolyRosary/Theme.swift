import SwiftUI

// MARK: - Catholic Rosary Theme

struct RosaryTheme {
    // Primary gold — warm, liturgical
    static let gold = Color(red: 0.83, green: 0.68, blue: 0.28)
    // Cream for light backgrounds / text on dark
    static let cream = Color(red: 0.98, green: 0.96, blue: 0.90)
    // Deep burgundy / wine
    static let burgundy = Color(red: 0.50, green: 0.10, blue: 0.15)
    // Rich dark background
    static let darkBg = Color(red: 0.08, green: 0.06, blue: 0.10)
    // Slightly lighter card surface
    static let cardBg = Color(red: 0.13, green: 0.11, blue: 0.16)
    // Muted text
    static let muted = Color(red: 0.65, green: 0.60, blue: 0.55)
}

// Convenience alias used by views
typealias Theme = _Theme
enum _Theme {
    static let gold = RosaryTheme.gold
    static let background = RosaryTheme.darkBg
    static let cardBackground = RosaryTheme.cardBg
    static let textPrimary = RosaryTheme.cream
    static let textMuted = RosaryTheme.muted
}
