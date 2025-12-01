import SwiftUI

struct DeepCleanView: View {
    var body: some View {
        VStack {
            Text("Deep Clean")
                .font(.largeTitle)
            Text("Deep cleaning removes system caches, logs, and unused languages.")
                .padding()
            
            Button("Start Deep Clean") {
                // Action
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
