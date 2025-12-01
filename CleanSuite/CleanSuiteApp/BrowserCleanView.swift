import SwiftUI

struct BrowserCleanView: View {
    var body: some View {
        VStack {
            Text("Browser Clean")
                .font(.largeTitle)
            Text("Clear cache for Safari, Chrome, and Firefox.")
                .padding()
            Button("Clean Browsers") {
                // Action
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
