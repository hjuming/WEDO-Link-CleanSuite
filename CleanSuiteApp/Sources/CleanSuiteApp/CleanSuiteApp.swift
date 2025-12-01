import SwiftUI

@main
struct CleanSuiteApp: App {
    var body: some Scene {
        WindowGroup {
            CleanSuiteDashboard()
        }
        .windowStyle(.hiddenTitleBar)
    }
}
