import Foundation

public class SystemScanner: ObservableObject {
    @Published public var isScanning = false
    @Published public var progress: Double = 0.0
    @Published public var currentScanningPath: String = ""
    
    public init() {}
    
    public func startScan() async -> CleanReport {
        await MainActor.run {
            self.isScanning = true
            self.progress = 0.0
            self.currentScanningPath = "Starting scan..."
        }
        
        var items: [CleanItem] = []
        
        // Define paths to scan
        let pathsToScan: [(path: String, category: CleanCategory)] = [
            (path: "~/Library/Caches", category: .systemCache),
            (path: "~/Library/Logs", category: .userLogs),
            (path: "~/.Trash", category: .trash),
            (path: "~/Library/Developer/Xcode/DerivedData", category: .xcodeDerivedData)
        ]
        
        let fileManager = FileManager.default
        let totalPaths = Double(pathsToScan.count)
        
        for (index, scanTarget) in pathsToScan.enumerated() {
            let expandedPath = (scanTarget.path as NSString).expandingTildeInPath
            
            await MainActor.run {
                self.currentScanningPath = "Scanning \(scanTarget.path)..."
            }
            
            if let size = getDirectorySize(url: URL(fileURLWithPath: expandedPath)) {
                if size > 0 {
                    let item = CleanItem(
                        name: URL(fileURLWithPath: expandedPath).lastPathComponent,
                        path: expandedPath,
                        size: size,
                        category: scanTarget.category
                    )
                    items.append(item)
                }
            }
            
            await MainActor.run {
                self.progress = Double(index + 1) / totalPaths
            }
        }
        
        await MainActor.run {
            self.isScanning = false
            self.currentScanningPath = "Scan Complete"
        }
        
        return CleanReport(items: items)
    }
    
    private func getDirectorySize(url: URL) -> Int64? {
        guard let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.totalFileAllocatedSizeKey]) else {
            return nil
        }
        
        var totalSize: Int64 = 0
        
        for case let fileURL as URL in enumerator {
            do {
                let resourceValues = try fileURL.resourceValues(forKeys: [.totalFileAllocatedSizeKey])
                if let fileSize = resourceValues.totalFileAllocatedSize {
                    totalSize += Int64(fileSize)
                }
            } catch {
                // Ignore errors for individual files
                continue
            }
        }
        
        return totalSize
    }
}
