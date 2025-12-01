import Foundation

class Scheduler {
    var timer: Timer?
    
    func start() {
        // Run loop every 30 minutes
        timer = Timer.scheduledTimer(withTimeInterval: 30 * 60, repeats: true) { _ in
            self.checkTasks()
        }
        // Run immediately on start
        checkTasks()
    }
    
    func checkTasks() {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let weekday = calendar.component(.weekday, from: now) // Sunday = 1
        
        // 1. Low Disk Check (Every 30 min)
        if Config.shared.lowDiskCleanEnabled {
            let freeSpace = DiskUtils.getFreeSpaceGB()
            if freeSpace < 20.0 {
                Logger.log("Disk space low (\(String(format: "%.2f", freeSpace)) GB). Triggering Quick Clean.")
                QuickCleaner.clean()
            }
        }
        
        // 2. Daily Clean (04:00)
        if Config.shared.dailyCleanEnabled {
            if let lastDate = Config.shared.lastDailyCleanDate {
                if !calendar.isDateInToday(lastDate) && hour >= 4 {
                    Logger.log("Triggering Daily Clean")
                    QuickCleaner.clean()
                    Config.shared.lastDailyCleanDate = now
                }
            } else {
                // First run
                Config.shared.lastDailyCleanDate = now
            }
        }
        
        // 3. Weekly Deep Clean (Sunday 02:00)
        if Config.shared.weeklyCleanEnabled {
            if let lastDate = Config.shared.lastWeeklyCleanDate {
                let daysSince = calendar.dateComponents([.day], from: lastDate, to: now).day ?? 0
                if daysSince >= 7 && weekday == 1 && hour >= 2 {
                    Logger.log("Triggering Weekly Deep Clean")
                    DeepCleaner.clean()
                    Config.shared.lastWeeklyCleanDate = now
                }
            } else {
                Config.shared.lastWeeklyCleanDate = now
            }
        }
    }
}
