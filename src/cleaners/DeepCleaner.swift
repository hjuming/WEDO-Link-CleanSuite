import Foundation

class DeepCleaner: Cleaner {
    static func clean() {
        Logger.log("Starting Deep Clean...")
        
        // 1. Mail
        MailCleaner.clean()
        
        // 2. Browsers
        BrowserCleaner.clean()
        
        // 3. LINE
        CleanerUtils.removeContent(at: "~/Library/Group Containers/VUTU7AKEUR.jp.naver.line.mac")
        
        // 4. Notion
        CleanerUtils.removeContent(at: "~/Library/Application Support/Notion/Cache")
        CleanerUtils.removeContent(at: "~/Library/Application Support/Notion/Code Cache")
        
        // 5. Eagle
        CleanerUtils.removeContent(at: "~/Library/Application Support/Eagle/Cache")
        
        // 6. Application Support Heavy Caches (Generic)
        // Be careful here, maybe just specific ones known to be safe/heavy
        
        Logger.log("Deep Clean Finished")
    }
}
