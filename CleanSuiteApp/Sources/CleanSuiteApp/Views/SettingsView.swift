import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings = SettingsManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("settings.title")
                .font(.largeTitle.bold())
            
            Form {
                Section {
                    Toggle("settings.autostart", isOn: $settings.autoStartEnabled)
                }
                
                Section(header: Text("Automation")) {
                    Toggle("settings.daily", isOn: $settings.dailyCleanEnabled)
                    Toggle("settings.weekly", isOn: $settings.weeklyCleanEnabled)
                    Toggle("settings.lowdisk", isOn: $settings.lowDiskCleanEnabled)
                }
                
                Section(header: Text("Targets")) {
                    Toggle("settings.mail", isOn: $settings.cleanMailEnabled)
                    Toggle("settings.browser", isOn: $settings.cleanBrowsersEnabled)
                    Toggle("settings.line", isOn: $settings.cleanLineEnabled)
                }
            }
            .formStyle(.grouped)
        }
        .padding()
    }
}
