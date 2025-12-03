import SwiftUI

struct DashboardView: View {
    @State private var freeSpace: String = "計算中..."
    @State private var totalSpace: String = "計算中..."
    @State private var usedPercentage: Double = 0.0
    @State private var lastCleanTime: String = "從未"
    @State private var isCleaning: Bool = false
    @State private var statusMessage: String = "就緒"

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                    .resizable()
                    .frame(width: 48, height: 48)
                VStack(alignment: .leading) {
                    Text("WEDO Link CleanSuite")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))

            Divider()

            // Storage Section
            VStack(alignment: .leading, spacing: 10) {
                Text("儲存空間使用量")
                    .font(.headline)

                HStack {
                    VStack(alignment: .leading) {
                        Text("可用空間")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(freeSpace)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("總空間")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(totalSpace)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }

                ProgressView(value: usedPercentage, total: 100)
                    .accentColor(usedPercentage > 90 ? .red : .blue)
            }
            .padding()
            .background(Color(NSColor.windowBackgroundColor))

            Divider()

            // Actions Section
            VStack(spacing: 15) {
                HStack(spacing: 20) {
                    ActionButton(title: "快速清理", icon: "wind", color: .blue) {
                        performClean(type: "Quick")
                    }
                    
                    ActionButton(title: "深度清理", icon: "trash", color: .orange) {
                        performClean(type: "Deep")
                    }
                }
                
                HStack(spacing: 20) {
                    ActionButton(title: "郵件清理", icon: "envelope", color: .purple) {
                        performClean(type: "Mail")
                    }
                    
                    ActionButton(title: "瀏覽器清理", icon: "globe", color: .green) {
                        performClean(type: "Browser")
                    }
                }
            }
            .padding()
            
            Spacer()
            
            // Status Footer
            HStack {
                Text(statusMessage)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                if isCleaning {
                    ProgressView()
                        .scaleEffect(0.5)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .frame(width: 500, height: 450)
        .onAppear {
            updateStorageInfo()
        }
    }

    func updateStorageInfo() {
        let free = DiskUtils.getFreeSpaceGB()
        let total = DiskUtils.getTotalSpaceGB()
        
        self.freeSpace = String(format: "%.1f GB", free)
        self.totalSpace = String(format: "%.1f GB", total)
        
        if total > 0 {
            self.usedPercentage = ((total - free) / total) * 100
        }
    }

    func performClean(type: String) {
        guard !isCleaning else { return }
        isCleaning = true
        
        var cleanName = ""
        switch type {
        case "Quick": cleanName = "快速"
        case "Deep": cleanName = "深度"
        case "Mail": cleanName = "郵件"
        case "Browser": cleanName = "瀏覽器"
        default: cleanName = type
        }
        
        statusMessage = "正在執行\(cleanName)清理..."
        
        DispatchQueue.global(qos: .userInitiated).async {
            switch type {
            case "Quick":
                QuickCleaner.clean()
            case "Deep":
                DeepCleaner.clean()
            case "Mail":
                MailCleaner.clean()
            case "Browser":
                BrowserCleaner.clean()
            default:
                break
            }
            
            DispatchQueue.main.async {
                self.isCleaning = false
                self.statusMessage = "\(cleanName)清理完成！"
                self.updateStorageInfo()
                
                // Reset message after delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.statusMessage = "就緒"
                }
            }
        }
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(color)
                    .padding(.bottom, 5)
                Text(title)
                    .font(.system(size: 12, weight: .medium))
            }
            .frame(width: 100, height: 80)
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(10)
            .shadow(radius: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
