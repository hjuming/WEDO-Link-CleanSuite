import SwiftUI

struct MailCleanView: View {
    var body: some View {
        VStack {
            Text("Mail Clean")
                .font(.largeTitle)
            Text("Remove mail attachments and old logs.")
                .padding()
            Button("Clean Mail") {
                // Action
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
