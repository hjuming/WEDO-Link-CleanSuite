import Foundation
import AppKit

class UpdateManager: ObservableObject {
    static let shared = UpdateManager()
    
    @Published var isChecking = false
    @Published var updateAvailable = false
    @Published var latestVersion: String?
    @Published var downloadURL: URL?
    
    private let currentVersion = "1.1.0"
    private let releasesURL = URL(string: "https://api.github.com/repos/hjuming/WEDO-Link-CleanSuite/releases/latest")!
    
    func checkForUpdates(userInitiated: Bool = false) {
        isChecking = true
        
        URLSession.shared.dataTask(with: releasesURL) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isChecking = false
                
                guard let data = data,
                      let release = try? JSONDecoder().decode(GitHubRelease.self, from: data) else {
                    if userInitiated { self?.showError("Failed to check for updates.") }
                    return
                }
                
                let serverVersion = release.tag_name.replacingOccurrences(of: "v", with: "")
                if serverVersion.compare(self?.currentVersion ?? "", options: .numeric) == .orderedDescending {
                    self?.updateAvailable = true
                    self?.latestVersion = serverVersion
                    self?.downloadURL = URL(string: release.assets.first?.browser_download_url ?? "")
                    
                    if userInitiated {
                        self?.showUpdateAlert(version: serverVersion, url: self?.downloadURL)
                    } else {
                        // Notify silently or show badge
                        CleaningManager.shared.sendNotification(title: "Update Available", body: "Version \(serverVersion) is available.")
                    }
                } else if userInitiated {
                    self?.showUpToDateAlert()
                }
            }
        }.resume()
    }
    
    func downloadAndInstall() {
        guard let url = downloadURL else { return }
        
        let destination = FileManager.default.temporaryDirectory.appendingPathComponent("CleanSuiteUpdate.pkg")
        
        URLSession.shared.downloadTask(with: url) { localURL, _, error in
            guard let localURL = localURL else { return }
            
            do {
                if FileManager.default.fileExists(atPath: destination.path) {
                    try FileManager.default.removeItem(at: destination)
                }
                try FileManager.default.moveItem(at: localURL, to: destination)
                
                DispatchQueue.main.async {
                    NSWorkspace.shared.open(destination)
                    NSApplication.shared.terminate(nil)
                }
            } catch {
                print("Update error: \(error)")
            }
        }.resume()
    }
    
    private func showUpdateAlert(version: String, url: URL?) {
        let alert = NSAlert()
        alert.messageText = NSLocalizedString("update.available", comment: "")
        alert.informativeText = "Version \(version) is available. Would you like to download it now?"
        alert.addButton(withTitle: NSLocalizedString("update.install", comment: ""))
        alert.addButton(withTitle: "Cancel")
        
        if alert.runModal() == .alertFirstButtonReturn {
            downloadAndInstall()
        }
    }
    
    private func showUpToDateAlert() {
        let alert = NSAlert()
        alert.messageText = NSLocalizedString("update.uptodate", comment: "")
        alert.runModal()
    }
    
    private func showError(_ message: String) {
        let alert = NSAlert()
        alert.messageText = "Error"
        alert.informativeText = message
        alert.runModal()
    }
}

struct GitHubRelease: Codable {
    let tag_name: String
    let assets: [GitHubAsset]
}

struct GitHubAsset: Codable {
    let browser_download_url: String
}
