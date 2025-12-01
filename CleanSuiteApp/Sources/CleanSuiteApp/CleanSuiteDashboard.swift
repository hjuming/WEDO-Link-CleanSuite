import SwiftUI

struct CleanSuiteDashboard: View {
    @State private var result: String = ""
    @State private var selectedItem: CleanSuiteItems? = .quick
    @State private var showSettings = false
    @State private var diskUsage = DiskMonitor.getDiskUsage()
    
    // Timer to update disk usage
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 0) {
            sidebar
                .background(Color(nsColor: .controlBackgroundColor))
            Divider()
            mainArea
                .background(Color(nsColor: .windowBackgroundColor))
        }
        .frame(minWidth: 900, minHeight: 600)
        .onReceive(timer) { _ in
            diskUsage = DiskMonitor.getDiskUsage()
        }
    }

    var sidebar: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("sidebar.title")
                .font(.title3.bold())
                .padding(.horizontal)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    Text("sidebar.section.cleaners")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 12)
                        .padding(.top, 8)
                    
                    ForEach(CleanSuiteItems.allCases, id: \.self) { item in
                        SidebarButton(title: item.titleKey, icon: item.icon, isSelected: selectedItem == item && !showSettings) {
                            selectedItem = item
                            showSettings = false
                            run(item.script)
                        }
                    }
                    
                    Divider().padding(.vertical, 8)
                    
                    SidebarButton(title: "settings.title", icon: "gear", isSystemIcon: true, isSelected: showSettings) {
                        showSettings = true
                        selectedItem = nil
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .frame(width: 240)
    }

    var mainArea: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top Bar with Storage
            HStack {
                VStack(alignment: .leading) {
                    Text("dashboard.storage.free")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(String(format: "%.1f", diskUsage.freeGB)) GB")
                        .font(.headline)
                }
                
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.secondary.opacity(0.2))
                        RoundedRectangle(cornerRadius: 4)
                            .fill(diskUsage.usedPercentage > 0.9 ? Color.red : Color.blue)
                            .frame(width: geo.size.width * diskUsage.usedPercentage)
                    }
                }
                .frame(height: 8)
                .padding(.horizontal)
                
                VStack(alignment: .trailing) {
                    Text("dashboard.storage.used")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(String(format: "%.1f", diskUsage.usedGB)) GB")
                        .font(.headline)
                }
            }
            .padding()
            .background(Color(nsColor: .controlBackgroundColor).opacity(0.5))
            
            Divider()
            
            if showSettings {
                SettingsView()
            } else if let item = selectedItem {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(nsImage: IconLoader.load(item.icon))
                            .resizable()
                            .frame(width: 48, height: 48)
                        VStack(alignment: .leading) {
                            Text(LocalizedStringKey(item.titleKey))
                                .font(.largeTitle.weight(.bold))
                            Text("dashboard.subtitle")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 30)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            if result.isEmpty {
                                Text("dashboard.ready")
                                    .foregroundStyle(.secondary)
                                    .italic()
                            } else {
                                Text(result)
                                    .font(.system(.body, design: .monospaced))
                                    .textSelection(.enabled)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(30)
                    }
                }
            }
        }
    }

    func run(_ script: String) {
        result = NSLocalizedString("dashboard.cleaning", comment: "") + "\n"
        CleaningManager.shared.runScript(script) { output in
            self.result = output
        }
    }
}

struct SidebarButton: View {
    let title: String
    let icon: String
    var isSystemIcon: Bool = false
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            if isSystemIcon {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            } else {
                Image(nsImage: IconLoader.load(icon))
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Text(LocalizedStringKey(title))
                .font(.system(size: 13))
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(isSelected ? Color.accentColor : Color.clear)
        .foregroundColor(isSelected ? .white : .primary)
        .cornerRadius(8)
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}
