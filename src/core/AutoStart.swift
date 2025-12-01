import Foundation

class AutoStart {
    static var isEnabled: Bool {
        let plistPath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/LaunchAgents/com.wedo.cleansuite.autostart.plist").path
        return FileManager.default.fileExists(atPath: plistPath)
    }
    
    static func toggle() {
        if isEnabled {
            disable()
        } else {
            enable()
        }
    }
    
    static func enable() {
        let plistContent = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>Label</key>
            <string>com.wedo.cleansuite.autostart</string>
            <key>ProgramArguments</key>
            <array>
                <string>/Applications/Wedo Link CleanSuite.app/Contents/MacOS/Wedo Link CleanSuite</string>
            </array>
            <key>RunAtLoad</key>
            <true/>
        </dict>
        </plist>
        """
        
        let plistUrl = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/LaunchAgents/com.wedo.cleansuite.autostart.plist")
        
        do {
            try plistContent.write(to: plistUrl, atomically: true, encoding: .utf8)
            Logger.log("AutoStart Enabled")
        } catch {
            Logger.log("Failed to enable AutoStart: \(error)")
        }
    }
    
    static func disable() {
        let plistUrl = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/LaunchAgents/com.wedo.cleansuite.autostart.plist")
        do {
            try FileManager.default.removeItem(at: plistUrl)
            Logger.log("AutoStart Disabled")
        } catch {
            Logger.log("Failed to disable AutoStart: \(error)")
        }
    }
}
