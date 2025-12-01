import Foundation

class BrowserCleaner: Cleaner {
    static func clean() {
        Logger.log("Starting Browser Clean...")
        
        // Chrome
        CleanerUtils.removeContent(at: "~/Library/Application Support/Google/Chrome/Default/Cache")
        
        // Safari
        CleanerUtils.removeContent(at: "~/Library/Caches/com.apple.Safari")
        
        // Edge
        CleanerUtils.removeContent(at: "~/Library/Application Support/Microsoft Edge/Default/Cache")
        
        Logger.log("Browser Clean Finished")
    }
}
