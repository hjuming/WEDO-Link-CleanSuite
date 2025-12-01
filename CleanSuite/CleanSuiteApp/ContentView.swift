import SwiftUI

struct ContentView: View {
    @State private var selection: Panel? = .dashboard
    
    enum Panel: Hashable {
        case dashboard
        case quickClean
        case deepClean
        case mailClean
        case browserClean
        case lineClean
        case scheduler
        case settings
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section(header: Text("Overview")) {
                    NavigationLink(value: Panel.dashboard) {
                        Label("Dashboard", systemImage: "gauge")
                    }
                }
                
                Section(header: Text("Cleaning")) {
                    NavigationLink(value: Panel.quickClean) {
                        Label("Quick Clean", systemImage: "bolt.fill")
                    }
                    NavigationLink(value: Panel.deepClean) {
                        Label("Deep Clean", systemImage: "trash.fill")
                    }
                    NavigationLink(value: Panel.mailClean) {
                        Label("Mail Clean", systemImage: "envelope.fill")
                    }
                    NavigationLink(value: Panel.browserClean) {
                        Label("Browser Clean", systemImage: "safari.fill")
                    }
                    NavigationLink(value: Panel.lineClean) {
                        Label("LINE Clean", systemImage: "bubble.left.and.bubble.right.fill")
                    }
                }
                
                Section(header: Text("Tools")) {
                    NavigationLink(value: Panel.scheduler) {
                        Label("Scheduler", systemImage: "calendar")
                    }
                    NavigationLink(value: Panel.settings) {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
            .navigationTitle("CleanSuite")
            .listStyle(SidebarListStyle())
        } detail: {
            switch selection {
            case .dashboard: DashboardView()
            case .quickClean: QuickCleanView()
            case .deepClean: DeepCleanView()
            case .mailClean: MailCleanView()
            case .browserClean: BrowserCleanView()
            case .lineClean: LINECleanView()
            case .scheduler: SchedulerView()
            case .settings: SettingsView()
            case .none: Text("Select an item")
            }
        }
    }
}
