import Foundation

class QuickCleaner: Cleaner {
    static func clean() {
        Logger.log("Starting Quick Clean...")
        
        let pathsToClean = [
            "~/Library/Caches",
            "/Library/Caches", // Requires root, might fail without sudo
            "~/.Trash",
            "~/Library/Application Support/Google/Chrome/Default/Cache",
            "~/Library/Application Support/Microsoft Edge/Default/Cache",
            "~/Library/Caches/com.apple.Safari"
        ]
        
        for path in pathsToClean {
            CleanerUtils.removeContent(at: path)
        }
        
        Logger.log("Quick Clean Finished")
    }
}
