import Foundation

enum CleanSuiteItems: CaseIterable {
    case quick, deep, mail, browser, weekly, daily, lowstorage, boot, line, chrome, safari

    var titleKey: String {
        switch self {
        case .quick: return "cleaner.quick"
        case .deep: return "cleaner.deep"
        case .mail: return "cleaner.mail"
        case .browser: return "cleaner.browser"
        case .weekly: return "settings.weekly"
        case .daily: return "settings.daily"
        case .lowstorage: return "settings.lowdisk"
        case .boot: return "settings.autostart"
        case .line: return "cleaner.line"
        case .chrome: return "cleaner.browser"
        case .safari: return "cleaner.browser"
        }
    }

    var icon: String {
        switch self {
        case .quick: return "app-icon.png" // Using app icon for general quick clean
        case .deep: return "clean-weekly-deep.png" // Reusing weekly deep icon
        case .mail: return "clean-mail.png"
        case .browser: return "clean-chrome.png" // Using chrome icon as generic browser
        case .weekly: return "clean-weekly-deep.png"
        case .daily: return "clean-daily.png"
        case .lowstorage: return "clean-low-storage.png"
        case .boot: return "clean-boot-quick.png"
        case .line: return "clean-line.png"
        case .chrome: return "clean-chrome.png"
        case .safari: return "clean-safari.png"
        }
    }

    var script: String {
        switch self {
        case .quick: return "/Library/CleanSuite/clean_quick.sh"
        case .deep: return "/Library/CleanSuite/clean_deep.sh"
        case .mail: return "/Library/CleanSuite/clean_mail.sh"
        case .browser: return "/Library/CleanSuite/clean_browser.sh"
        // For schedulers/toggles, we might just run a status check or toggle script
        // For now pointing to placeholders or re-using scripts as appropriate for the demo
        case .weekly: return "/Library/CleanSuite/clean_deep.sh"
        case .daily: return "/Library/CleanSuite/clean_quick.sh"
        case .lowstorage: return "/Library/CleanSuite/clean_quick.sh"
        case .boot: return "/Library/CleanSuite/clean_quick.sh"
        case .line: return "/Library/CleanSuite/clean_quick.sh" // Placeholder
        case .chrome: return "/Library/CleanSuite/clean_browser.sh"
        case .safari: return "/Library/CleanSuite/clean_browser.sh"
        }
    }
}
