import SwiftUI

@main
struct CleanSuiteApp: App {
    @StateObject var updater = AppUpdater()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandGroup(after: .appInfo) {
                Button("Check for Updates…") {
                    updater.checkForUpdates()
                }
            }
        }
    }
}
