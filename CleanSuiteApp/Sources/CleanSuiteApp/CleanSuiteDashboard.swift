import SwiftUI

struct CleanSuiteDashboard: View {
    @State private var result: String = ""
    @State private var selectedItem: CleanSuiteItems? = .quick
    
    var body: some View {
        HStack(spacing: 0) {
            sidebar
                .background(Color(nsColor: .controlBackgroundColor))
            Divider()
            mainArea
                .background(Color(nsColor: .windowBackgroundColor))
        }
        .frame(minWidth: 900, minHeight: 600)
    }

    var sidebar: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("WEDO Link\nCleanSuite")
                .font(.title3.bold())
                .padding(.horizontal)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(CleanSuiteItems.allCases, id: \.self) { item in
                        HStack {
                            Image(nsImage: IconLoader.load(item.icon))
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(item.title)
                                .font(.system(size: 13))
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(selectedItem == item ? Color.accentColor : Color.clear)
                        .foregroundColor(selectedItem == item ? .white : .primary)
                        .cornerRadius(8)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedItem = item
                            run(item.script)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .frame(width: 240)
    }

    var mainArea: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let item = selectedItem {
                HStack {
                    Image(nsImage: IconLoader.load(item.icon))
                        .resizable()
                        .frame(width: 48, height: 48)
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.largeTitle.weight(.bold))
                        Text("Professional Cleaning Module")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
            }
            
            Divider()
                .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .leading) {
                    if result.isEmpty {
                        Text("Ready to clean...")
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

    func run(_ script: String) {
        result = "Running \(script)...\n"
        
        DispatchQueue.global(qos: .userInitiated).async {
            let task = Process()
            task.launchPath = "/bin/bash"
            task.arguments = [script]
            let pipe = Pipe()
            task.standardOutput = pipe
            task.standardError = pipe
            
            do {
                try task.run()
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                if let output = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.result += "\n" + output + "\nDone."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.result += "\nError: \(error.localizedDescription)"
                }
            }
        }
    }
}
