import SwiftUI

@main
struct HolyRosaryApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Rosary", systemImage: "cross.fill")
                    }
                NovenaListView()
                    .tabItem {
                        Label("Novenas", systemImage: "flame.fill")
                    }
            }
            .tint(RosaryTheme.gold)
        }
    }
}
