import Foundation

class MailCleaner: Cleaner {
    static func clean() {
        Logger.log("Starting Mail Clean...")
        
        let mailPath = NSString(string: "~/Library/Mail").expandingTildeInPath
        let fileManager = FileManager.default
        
        var initialSize: Int64 = 0
        var finalSize: Int64 = 0
        
        // Calculate initial size (simplified, just checking V* folders)
        initialSize = getSize(of: mailPath)
        
        // Clean Attachments in V* folders
        if let enumerator = fileManager.enumerator(atPath: mailPath) {
            while let element = enumerator.nextObject() as? String {
                if element.contains("Attachments") {
                    let fullPath = (mailPath as NSString).appendingPathComponent(element)
                    CleanerUtils.removeContent(at: fullPath)
                }
            }
        }
        
        // Clean Downloads
        CleanerUtils.removeContent(at: "~/Library/Containers/com.apple.mail/Data/Library/Mail Downloads")
        
        // Calculate final size
        finalSize = getSize(of: mailPath)
        
        let saved = Double(initialSize - finalSize) / 1024 / 1024
        Logger.log("Mail Clean Finished. Saved: \(String(format: "%.2f", saved)) MB")
    }
    
    static func getSize(of path: String) -> Int64 {
        var size: Int64 = 0
        let fileManager = FileManager.default
        if let enumerator = fileManager.enumerator(at: URL(fileURLWithPath: path), includingPropertiesForKeys: [.fileSizeKey]) {
            for case let fileURL as URL in enumerator {
                if let resourceValues = try? fileURL.resourceValues(forKeys: [.fileSizeKey]),
                   let fileSize = resourceValues.fileSize {
                    size += Int64(fileSize)
                }
            }
        }
        return size
    }
}
