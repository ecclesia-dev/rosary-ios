import SwiftUI

@main
struct HolyRosaryApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "cross.fill")
                        Text("Rosary")
                    }
                NovenaListView()
                    .tabItem {
                        Image(systemName: "flame.fill")
                        Text("Novenas")
                    }
            }
            .tint(RosaryTheme.gold)
        }
    }
}
