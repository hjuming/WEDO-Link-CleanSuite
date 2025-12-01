import Foundation
import UserNotifications

class CleaningManager {
    static let shared = CleaningManager()
    
    private let logPath = FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent("Library/Logs/CleanSuite/history.log")
    
    init() {
        try? FileManager.default.createDirectory(at: logPath.deletingLastPathComponent(), withIntermediateDirectories: true)
    }
    
    func runScript(_ scriptPath: String, completion: @escaping (String) -> Void) {
        let initialDisk = DiskMonitor.getDiskUsage()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let task = Process()
            task.launchPath = "/bin/bash"
            task.arguments = [scriptPath]
            
            let pipe = Pipe()
            task.standardOutput = pipe
            task.standardError = pipe
            
            do {
                try task.run()
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                let output = String(data: data, encoding: .utf8) ?? ""
                
                // Post-clean analysis
                let finalDisk = DiskMonitor.getDiskUsage()
                let freedSpace = finalDisk.free - initialDisk.free
                let freedMB = Double(freedSpace) / 1_000_000.0
                
                let logEntry = """
                [\(Date())] Script: \(scriptPath)
                Freed: \(String(format: "%.2f", freedMB)) MB
                Output:
                \(output)
                --------------------------------------------------
                
                """
                self.appendLog(logEntry)
                self.sendNotification(title: "Cleaning Complete", body: "Freed \(String(format: "%.2f", freedMB)) MB of space.")
                
                DispatchQueue.main.async {
                    completion(output + "\n\nFreed: \(String(format: "%.2f", freedMB)) MB")
                }
            } catch {
                DispatchQueue.main.async {
                    completion("Error running script: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func appendLog(_ text: String) {
        if let data = text.data(using: .utf8) {
            if FileManager.default.fileExists(atPath: logPath.path) {
                if let fileHandle = try? FileHandle(forWritingTo: logPath) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                }
            } else {
                try? data.write(to: logPath)
            }
        }
    }
    
    private func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
