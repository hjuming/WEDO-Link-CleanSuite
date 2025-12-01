import Foundation

class DiskUtils {
    static func getFreeSpaceGB() -> Double {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory())
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityKey])
            if let capacity = values.volumeAvailableCapacity {
                return Double(capacity) / 1024 / 1024 / 1024
            }
        } catch {
            Logger.log("Error checking disk space: \(error)")
        }
        return 0.0
    }
}
