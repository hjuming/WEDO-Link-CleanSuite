import Cocoa
import SwiftUI

class MainWindowController: NSWindowController {
    convenience init() {
        let dashboardView = DashboardView()
        let hostingController = NSHostingController(rootView: dashboardView)
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 500, height: 450),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        window.center()
        window.title = "WEDO Link CleanSuite"
        window.contentViewController = hostingController
        window.titlebarAppearsTransparent = true
        window.isMovableByWindowBackground = true
        
        self.init(window: window)
    }
}
