import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List {
                Text("主控台")
                Text("快速清理")
                Text("深度清理")
                Text("郵件清理")
                Text("瀏覽器清理")
                Text("LINE 清理")
            }
            .navigationTitle("CleanSuite")
        } detail: {
            Text("準備開始清理系統 🧹✨")
        }
    }
}
