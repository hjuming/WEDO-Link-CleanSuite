import SwiftUI

struct SchedulerView: View {
    @State private var isEnabled = false
    @State private var selectedTime = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Schedule")) {
                Toggle("Enable Auto-Clean", isOn: $isEnabled)
                DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .disabled(!isEnabled)
            }
        }
        .padding()
        .navigationTitle("Scheduler")
    }
}
