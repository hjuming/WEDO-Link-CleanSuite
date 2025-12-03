import Foundation

public class ScanHelper {
    public static func getDiskUsage() -> (total: String, free: String, used: String, percent: Double) {
        let fileURL = URL(fileURLWithPath: "/")
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeTotalCapacityKey, .volumeAvailableCapacityKey])
            if let total = values.volumeTotalCapacity, let free = values.volumeAvailableCapacity {
                let used = Int64(total - free)
                let percent = Double(used) / Double(total)
                
                let formatter = ByteCountFormatter()
                formatter.countStyle = .file
                
                return (
                    total: formatter.string(fromByteCount: Int64(total)),
                    free: formatter.string(fromByteCount: Int64(free)),
                    used: formatter.string(fromByteCount: used),
                    percent: percent
                )
            }
        } catch {
            print("Error retrieving disk usage: \(error.localizedDescription)")
        }
        return ("0 GB", "0 GB", "0 GB", 0.0)
    }
}
