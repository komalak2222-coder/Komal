import SwiftUI

@main
struct OGManagerApp: App {
    @StateObject private var contentStore = ContentStore()

    var body: some Scene {
        WindowGroup("OG Manager") {
            ContentView()
                .environmentObject(contentStore)
                .frame(minWidth: 980, minHeight: 640)
        }
    }
}
