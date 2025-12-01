import SwiftUI

struct LINECleanView: View {
    var body: some View {
        VStack {
            Text("LINE Clean")
                .font(.largeTitle)
            Text("Remove temporary files from LINE.")
                .padding()
            Button("Clean LINE") {
                // Action
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
