// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CleanSuite",
    platforms: [ .macOS(.v13) ],
    products: [.executable(name: "CleanSuite", targets: ["CleanSuite"])],
    targets: [
        .executableTarget(
            name: "CleanSuite",
            path: "CleanSuiteApp"
        )
    ]
)
