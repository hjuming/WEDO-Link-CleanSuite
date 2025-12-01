import Cocoa
import Foundation

// Main Application Delegate
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var scheduler: Scheduler!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Setup Menubar
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            // Try to load icon
            let iconName = isDarkMode() ? "menubar_active.png" : "menubar_inactive.png"
            let iconPath = Bundle.main.path(forResource: iconName, ofType: nil) ?? "assets/icons/\(iconName)"
            
            if let image = NSImage(contentsOfFile: iconPath) {
                image.size = NSSize(width: 18, height: 18)
                button.image = image
            } else {
                button.title = "🧹" // Fallback
            }
        }
        
        setupMenu()
        
        // Initialize Scheduler
        scheduler = Scheduler()
        scheduler.start()
        
        // Check for updates
        Updater.checkForUpdates()
        
        Logger.log("App started")
    }
    
    func setupMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "立即清理 (Clean Now)", action: #selector(cleanNow), keyEquivalent: "c"))
        menu.addItem(NSMenuItem.separator())
        
        let autoCleanItem = NSMenuItem(title: "開機自動清理", action: #selector(toggleAutoStart), keyEquivalent: "")
        autoCleanItem.state = AutoStart.isEnabled ? .on : .off
        menu.addItem(autoCleanItem)
        
        let dailyCleanItem = NSMenuItem(title: "每天清理 (Daily)", action: #selector(toggleDailyClean), keyEquivalent: "")
        dailyCleanItem.state = Config.shared.dailyCleanEnabled ? .on : .off
        menu.addItem(dailyCleanItem)
        
        let weeklyCleanItem = NSMenuItem(title: "每週深度清理 (Weekly)", action: #selector(toggleWeeklyClean), keyEquivalent: "")
        weeklyCleanItem.state = Config.shared.weeklyCleanEnabled ? .on : .off
        menu.addItem(weeklyCleanItem)
        
        let lowDiskItem = NSMenuItem(title: "磁碟低於 20GB 自動清理", action: #selector(toggleLowDiskClean), keyEquivalent: "")
        lowDiskItem.state = Config.shared.lowDiskCleanEnabled ? .on : .off
        menu.addItem(lowDiskItem)
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "開啟主視窗...", action: #selector(openMainWindow), keyEquivalent: "o"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "退出 (Quit)", action: #selector(quit), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    @objc func cleanNow() {
        Logger.log("Manual Clean Triggered")
        QuickCleaner.clean()
    }
    
    @objc func toggleAutoStart(_ sender: NSMenuItem) {
        AutoStart.toggle()
        sender.state = AutoStart.isEnabled ? .on : .off
    }
    
    @objc func toggleDailyClean(_ sender: NSMenuItem) {
        Config.shared.dailyCleanEnabled.toggle()
        sender.state = Config.shared.dailyCleanEnabled ? .on : .off
    }
    
    @objc func toggleWeeklyClean(_ sender: NSMenuItem) {
        Config.shared.weeklyCleanEnabled.toggle()
        sender.state = Config.shared.weeklyCleanEnabled ? .on : .off
    }
    
    @objc func toggleLowDiskClean(_ sender: NSMenuItem) {
        Config.shared.lowDiskCleanEnabled.toggle()
        sender.state = Config.shared.lowDiskCleanEnabled ? .on : .off
    }
    
    @objc func openMainWindow() {
        // Placeholder for main window
        let alert = NSAlert()
        alert.messageText = "WEDO Link CleanSuite"
        alert.informativeText = "Version 1.0\n\nDisk Space: \(DiskUtils.getFreeSpaceGB()) GB Free"
        alert.runModal()
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
    
    func isDarkMode() -> Bool {
        let mode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
        return mode == "Dark"
    }
}

// Main Entry Point
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
