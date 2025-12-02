import Sparkle
import SwiftUI

class AppUpdater: ObservableObject {
    let updaterController: SPUStandardUpdaterController

    init() {
        self.updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
    }

    func checkForUpdates() {
        updaterController.checkForUpdates(nil)
    }
}
