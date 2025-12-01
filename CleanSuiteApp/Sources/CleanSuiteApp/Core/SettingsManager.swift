import Foundation

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    
    private let defaults = UserDefaults(suiteName: "com.wedo.cleansuite") ?? .standard
    
    @Published var dailyCleanEnabled: Bool {
        didSet { defaults.set(dailyCleanEnabled, forKey: "dailyCleanEnabled") }
    }
    
    @Published var weeklyCleanEnabled: Bool {
        didSet { defaults.set(weeklyCleanEnabled, forKey: "weeklyCleanEnabled") }
    }
    
    @Published var lowDiskCleanEnabled: Bool {
        didSet { defaults.set(lowDiskCleanEnabled, forKey: "lowDiskCleanEnabled") }
    }
    
    @Published var cleanMailEnabled: Bool {
        didSet { defaults.set(cleanMailEnabled, forKey: "cleanMailEnabled") }
    }
    
    @Published var cleanBrowsersEnabled: Bool {
        didSet { defaults.set(cleanBrowsersEnabled, forKey: "cleanBrowsersEnabled") }
    }
    
    @Published var cleanLineEnabled: Bool {
        didSet { defaults.set(cleanLineEnabled, forKey: "cleanLineEnabled") }
    }
    
    @Published var autoStartEnabled: Bool {
        didSet { defaults.set(autoStartEnabled, forKey: "autoStartEnabled") }
    }
    
    private init() {
        self.dailyCleanEnabled = defaults.bool(forKey: "dailyCleanEnabled")
        self.weeklyCleanEnabled = defaults.bool(forKey: "weeklyCleanEnabled")
        self.lowDiskCleanEnabled = defaults.bool(forKey: "lowDiskCleanEnabled")
        self.cleanMailEnabled = defaults.bool(forKey: "cleanMailEnabled")
        self.cleanBrowsersEnabled = defaults.bool(forKey: "cleanBrowsersEnabled")
        self.cleanLineEnabled = defaults.bool(forKey: "cleanLineEnabled")
        self.autoStartEnabled = defaults.bool(forKey: "autoStartEnabled")
    }
}
