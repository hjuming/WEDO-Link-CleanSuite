import SwiftUI

struct ContentView: View {
    @State private var output = "歡迎使用 CleanSuite！"

    var body: some View {
        VStack(spacing: 20) {
            Text("CleanSuite")
                .font(.largeTitle.bold())
            Text(output)
                .foregroundStyle(.secondary)

            Button("快速清理") { runCleaner("quick") }
                .buttonStyle(.borderedProminent)

            Button("深度清理") { runCleaner("deep") }
                .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
    }

    func runCleaner(_ type: String) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/local/bin/cleansuite")
        task.arguments = [type]

        let pipe = Pipe()
        task.standardOutput = pipe

        try? task.run()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        output = String(data: data, encoding: .utf8) ?? "執行完成"
    }
}
