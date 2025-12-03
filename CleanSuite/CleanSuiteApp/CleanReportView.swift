import SwiftUI

struct CleanReportView: View {
    let report: CleanReport
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .foregroundColor(.green)
                .frame(width: 60, height: 60)
                .padding(.top)
            
            Text("Cleaning Complete")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("You have successfully freed")
                .font(.headline)
            
            Text(report.formattedTotalSize)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
            
            Divider()
            
            List(report.items) { item in
                HStack {
                    Image(systemName: item.category.icon)
                        .foregroundColor(.secondary)
                        .frame(width: 24)
                    
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .fontWeight(.medium)
                        Text(item.path)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }
                    
                    Spacer()
                    
                    Text(item.formattedSize)
                        .font(.callout)
                        .monospacedDigit()
                }
                .padding(.vertical, 4)
            }
            .listStyle(.inset)
            
            HStack {
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .keyboardShortcut(.defaultAction)
                .controlSize(.large)
            }
            .padding(.bottom)
        }
        .frame(minWidth: 500, minHeight: 600)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

struct CleanReportView_Previews: PreviewProvider {
    static var previews: some View {
        CleanReportView(report: CleanReport(items: [
            CleanItem(name: "Cache", path: "/Library/Caches", size: 1024 * 1024 * 50, category: .systemCache),
            CleanItem(name: "Logs", path: "/Library/Logs", size: 1024 * 1024 * 10, category: .userLogs)
        ]))
    }
}
