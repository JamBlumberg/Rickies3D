import SwiftUI

@main
struct Rickies_3DApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(
                    LinearGradient(
                        colors: [.green, .yellow, .orange, .red, .purple, .indigo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .ignoresSafeArea()

        }
    }
}
