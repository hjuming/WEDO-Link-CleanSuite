import Foundation

protocol Cleaner {
    static func clean()
}

class CleanerUtils {
    static func removeContent(at path: String) {
        let fileManager = FileManager.default
        let expandedPath = NSString(string: path).expandingTildeInPath
        
        if fileManager.fileExists(atPath: expandedPath) {
            do {
                // Get contents
                let contents = try fileManager.contentsOfDirectory(atPath: expandedPath)
                for item in contents {
                    let itemPath = (expandedPath as NSString).appendingPathComponent(item)
                    try fileManager.removeItem(atPath: itemPath)
                }
                Logger.log("Cleaned: \(path)")
            } catch {
                Logger.log("Error cleaning \(path): \(error)")
            }
        }
    }
    
    static func removeFile(at path: String) {
        let fileManager = FileManager.default
        let expandedPath = NSString(string: path).expandingTildeInPath
        
        if fileManager.fileExists(atPath: expandedPath) {
            do {
                try fileManager.removeItem(atPath: expandedPath)
                Logger.log("Removed file: \(path)")
            } catch {
                Logger.log("Error removing file \(path): \(error)")
            }
        }
    }
}
