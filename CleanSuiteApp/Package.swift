// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "CleanSuiteApp",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "CleanSuiteApp", targets: ["CleanSuiteApp"])
    ],
    targets: [
        .executableTarget(
            name: "CleanSuiteApp",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
