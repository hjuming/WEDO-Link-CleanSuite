import SwiftUI

struct SystemScanView: View {
    @StateObject private var scanner = SystemScanner()
    @State private var scanReport: CleanReport?
    @State private var showReport = false
    @State private var diskUsage: (total: String, free: String, used: String, percent: Double)?
    
    var body: some View {
        VStack(spacing: 30) {
            // Header
            VStack(spacing: 10) {
                Image(systemName: "waveform.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.accentColor)
                
                Text("Smart System Scan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if let usage = diskUsage {
                    Text("Disk Usage: \(usage.used) used of \(usage.total)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.top, 40)
            
            Spacer()
            
            // Main Content
            if scanner.isScanning {
                VStack(spacing: 20) {
                    ProgressView(value: scanner.progress) {
                        Text("Scanning System...")
                            .font(.headline)
                    }
                    .progressViewStyle(.linear)
                    .frame(width: 300)
                    
                    Text(scanner.currentScanningPath)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .frame(width: 400)
                }
            } else if let report = scanReport {
                VStack(spacing: 20) {
                    Text("Scan Complete")
                        .font(.title2)
                    
                    Text("Found Junk: \(report.formattedTotalSize)")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.red)
                    
                    Button(action: {
                        // Simulate cleaning
                        showReport = true
                    }) {
                        Label("Clean Now", systemImage: "trash")
                            .font(.title3)
                            .frame(width: 150, height: 40)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            } else {
                VStack(spacing: 15) {
                    Text("Ready to optimize your Mac")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Button(action: {
                        Task {
                            let report = await scanner.startScan()
                            self.scanReport = report
                        }
                    }) {
                        Text("Start Scan")
                            .font(.title3)
                            .frame(width: 150, height: 40)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
            }
            
            Spacer()
        }
        .frame(minWidth: 600, minHeight: 500)
        .onAppear {
            self.diskUsage = ScanHelper.getDiskUsage()
        }
        .sheet(isPresented: $showReport) {
            if let report = scanReport {
                CleanReportView(report: report)
            }
        }
    }
}

struct SystemScanView_Previews: PreviewProvider {
    static var previews: some View {
        SystemScanView()
    }
}
