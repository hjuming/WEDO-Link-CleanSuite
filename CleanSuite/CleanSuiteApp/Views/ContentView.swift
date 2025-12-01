import SwiftUI

struct ContentView: View {
    @State private var diskFree: Double = ProcessInfo.processInfo.physicalMemory // Placeholder
    @State private var message = "歡迎使用 CleanSuite！"

    var body: some View {
        VStack(spacing: 20) {
            Text("CleanSuite")
                .font(.largeTitle)
                .bold()

            Text(message)
                .foregroundColor(.secondary)

            Button("執行快速清理") {
                message = runCleaner("quick")
            }
            .buttonStyle(.borderedProminent)

            Button("執行深度清理") {
                message = runCleaner("deep")
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
    }

    func runCleaner(_ type: String) -> String {
        let task = Process()
        task.launchPath = "/usr/local/bin/cleansuite"
        task.arguments = [type]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? "清理已完成"
    }
}
