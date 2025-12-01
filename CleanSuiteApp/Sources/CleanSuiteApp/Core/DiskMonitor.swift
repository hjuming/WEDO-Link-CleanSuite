import Foundation

struct DiskUsage {
    let total: Int64
    let free: Int64
    let used: Int64
    
    var totalGB: Double { Double(total) / 1_000_000_000 }
    var freeGB: Double { Double(free) / 1_000_000_000 }
    var usedGB: Double { Double(used) / 1_000_000_000 }
    var usedPercentage: Double { Double(used) / Double(total) }
}

class DiskMonitor {
    static func getDiskUsage() -> DiskUsage {
        let fileURL = URL(fileURLWithPath: "/")
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeTotalCapacityKey, .volumeAvailableCapacityForImportantUsageKey])
            if let total = values.volumeTotalCapacity,
               let free = values.volumeAvailableCapacityForImportantUsage {
                return DiskUsage(total: Int64(total), free: Int64(free), used: Int64(total - free))
            }
        } catch {
            print("Error retrieving disk usage: \(error)")
        }
        return DiskUsage(total: 0, free: 0, used: 0)
    }
}
