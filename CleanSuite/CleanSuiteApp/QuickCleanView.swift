import SwiftUI

struct QuickCleanView: View {
    @State private var isCleaning = false
    @State private var progress = 0.0
    
    var body: some View {
        VStack {
            Text("Quick Clean")
                .font(.largeTitle)
            
            if isCleaning {
                ProgressView("Cleaning...", value: progress, total: 100)
                    .padding()
            } else {
                Button("Start Quick Clean") {
                    startCleaning()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
        .padding()
    }
    
    func startCleaning() {
        isCleaning = true
        progress = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            progress += 5
            if progress >= 100 {
                timer.invalidate()
                isCleaning = false
            }
        }
    }
}
