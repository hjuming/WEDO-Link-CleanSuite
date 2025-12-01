# CleanSuite

![Platform](https://img.shields.io/badge/Platform-macOS-lightgrey.svg)
![macOS](https://img.shields.io/badge/macOS-13.0%2B-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Build Status](https://github.com/hjuming/WEDO-Link-CleanSuite/actions/workflows/build.yml/badge.svg)

**CleanSuite** is a modern, lightweight system maintenance utility designed for macOS. Built entirely with **SwiftUI**, it provides a sleek and intuitive interface for managing system storage, cleaning caches, and optimizing performance.

> **Note**: This project is currently in **v1.2.1**. The UI modules are fully implemented, while the core cleaning logic and system scanning engines are under active development for future releases.

---

## 🚀 Features

CleanSuite is modularized into several key components to ensure maintainability and scalability.

| Module | Description |
| :--- | :--- |
| **Dashboard** | Overview of system health, storage usage, and quick actions. |
| **Quick Clean** | Fast scanning and removal of common temporary files and caches. |
| **Deep Clean** | Thorough system scan for large files, old logs, and redundant data. |
| **Browser Clean** | specialized cleaning for Safari, Chrome, and Firefox caches/history. |
| **Mail Clean** | Removal of local mail attachments and unnecessary downloads. |
| **LINE Clean** | Targeted cleaning for LINE application caches and temporary files. |
| **Scheduler** | Automation settings for periodic background cleaning tasks. |
| **Settings** | User preferences for app behavior, notifications, and updates. |

### Core Components
- **CleanSuiteApp**: The main macOS application target containing all SwiftUI views and logic.
- **CleanSuiteHelper**: A helper module for privileged system operations (future implementation).
- **Shared**: Common utilities and data models shared across targets.

---

## 📥 Installation

### Download from Releases
You can download the latest stable version (`.pkg` installer) from the [GitHub Releases](https://github.com/hjuming/WEDO-Link-CleanSuite/releases) page.

### Installation Steps
1. Download `CleanSuite.pkg` from the latest release.
2. Double-click the `.pkg` file to launch the installer.
3. Follow the on-screen instructions to install CleanSuite to your `/Applications` folder.

> **⚠️ Important Note on Security**:
> Since this app is currently **unsigned** (not notarized by Apple), you may see a security warning when opening it for the first time.
>
> **To bypass this:**
> 1. Right-click (or Control-click) on `CleanSuite.app` in your Applications folder.
> 2. Select **Open** from the context menu.
> 3. Click **Open** in the dialog box that appears.
>
> You only need to do this once.

---

## 🛠 Development Setup

If you wish to contribute or build the project from source, follow these steps.

### Prerequisites
- **macOS 13.0** (Ventura) or later
- **Xcode 14.2+** (Recommended: Xcode 16.0+)
- **Swift 5.0+**

### Getting Started
1. **Clone the repository**:
   ```bash
   git clone https://github.com/hjuming/WEDO-Link-CleanSuite.git
   cd WEDO-Link-CleanSuite
   ```

2. **Open the Project**:
   Double-click `CleanSuite/CleanSuite.xcodeproj` to open it in Xcode.

3. **Build Settings**:
   - **Target**: `CleanSuite`
   - **Deployment Target**: macOS 13.0
   - **Swift Version**: 5.0
   - **Signing**: Manual (Code Sign Identity: `-`)

4. **Run**:
   Select the `CleanSuite` scheme and press `Cmd + R` to build and run.

---

## 📂 Project Structure

```text
CleanSuite/
├── CleanSuite.xcodeproj       # Xcode Project File
├── CleanSuiteApp/             # Main Application Source
│   ├── CleanSuiteApp.swift    # App Entry Point (@main)
│   ├── ContentView.swift      # Root View
│   ├── DashboardView.swift    # Dashboard UI
│   ├── QuickCleanView.swift   # Quick Clean UI
│   ├── ... (Other Views)
│   ├── Assets.xcassets/       # App Icons and Images
│   └── Info.plist             # App Configuration
├── CleanSuiteHelper/          # Helper Module Source
│   └── Helper.swift
├── shared/                    # Shared Code
│   └── Shared.swift
├── CLI/                       # Command Line Tools
│   └── cleansuite
├── Package.swift              # Swift Package Definition
└── README.md                  # Project Documentation
```

---

## 🤖 Build & Release Automation

This project uses **GitHub Actions** for continuous integration and deployment.

- **Workflow File**: `.github/workflows/build.yml`
- **Runner**: `macos-15-arm64` (Apple Silicon)

### Workflow Steps
1. **Checkout Code**: Pulls the latest code from the repository.
2. **Setup Xcode**: Selects the appropriate Xcode version.
3. **Build**: Uses `xcodebuild` to compile the `CleanSuite` scheme in `Release` configuration.
   ```bash
   xcodebuild -project CleanSuite/CleanSuite.xcodeproj -scheme CleanSuite -configuration Release ...
   ```
4. **Package**: Creates a standard macOS installer package (`CleanSuite.pkg`) using `productbuild`.
5. **Release**: Automatically uploads the `.pkg` file to GitHub Releases when a tag starting with `v*` is pushed.

---

## 🔖 Versioning

CleanSuite follows [Semantic Versioning](https://semver.org/).
- **Current Version**: `v1.2.1`
- **Format**: `vMajor.Minor.Patch`

To release a new version:
```bash
git tag v1.3.0
git push origin v1.3.0
```
This will trigger the GitHub Actions workflow to build and publish the new release.

---

## 🗺 Roadmap

- [x] **v1.0**: Initial Project Structure & UI Framework
- [x] **v1.2**: Complete SwiftUI Interface Implementation
- [ ] **v1.3**: Core Cleaning Engine Implementation
- [ ] **v1.4**: System Scanning Logic & Deep Clean
- [ ] **v1.5**: Scheduler & Automation Features
- [ ] **v2.0**: Cloud Sync & Preferences
- [ ] **Future**: Notarization & Signed Distribution

---

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ for macOS
</p>
