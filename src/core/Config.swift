import Foundation

class Config {
    static let shared = Config()
    
    private let defaults = UserDefaults.standard
    
    var dailyCleanEnabled: Bool {
        get { defaults.bool(forKey: "DailyCleanEnabled") }
        set { defaults.set(newValue, forKey: "DailyCleanEnabled") }
    }
    
    var weeklyCleanEnabled: Bool {
        get { defaults.bool(forKey: "WeeklyCleanEnabled") }
        set { defaults.set(newValue, forKey: "WeeklyCleanEnabled") }
    }
    
    var lowDiskCleanEnabled: Bool {
        get { defaults.bool(forKey: "LowDiskCleanEnabled") }
        set { defaults.set(newValue, forKey: "LowDiskCleanEnabled") }
    }
    
    var lastDailyCleanDate: Date? {
        get { defaults.object(forKey: "LastDailyCleanDate") as? Date }
        set { defaults.set(newValue, forKey: "LastDailyCleanDate") }
    }
    
    var lastWeeklyCleanDate: Date? {
        get { defaults.object(forKey: "LastWeeklyCleanDate") as? Date }
        set { defaults.set(newValue, forKey: "LastWeeklyCleanDate") }
    }
}
