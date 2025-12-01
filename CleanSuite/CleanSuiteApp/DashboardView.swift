import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Dashboard")
                .font(.largeTitle)
            
            HStack {
                DiskUsageView(title: "Macintosh HD", used: 0.75)
                DiskUsageView(title: "External Drive", used: 0.45)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct DiskUsageView: View {
    var title: String
    var used: Double
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .foregroundColor(Color.blue)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.used, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: used)
                
                Text(String(format: "%.0f %%", min(self.used, 1.0)*100.0))
                    .font(.title)
                    .bold()
            }
            .frame(width: 150, height: 150)
        }
        .padding()
    }
}
