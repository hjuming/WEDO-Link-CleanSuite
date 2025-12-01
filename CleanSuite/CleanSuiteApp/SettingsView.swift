import SwiftUI

struct SettingsView: View {
    @State private var autoUpdate = true
    @State private var language = "en"
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                Toggle("Auto-Update", isOn: $autoUpdate)
                Picker("Language", selection: $language) {
                    Text("English").tag("en")
                    Text("Traditional Chinese").tag("zh-Hant")
                }
            }
        }
        .padding()
        .navigationTitle("Settings")
    }
}
