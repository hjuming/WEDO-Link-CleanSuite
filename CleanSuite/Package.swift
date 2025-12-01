// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CleanSuite",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "CleanSuiteApp", targets: ["CleanSuiteApp"]),
        .library(name: "CleanSuiteHelper", targets: ["CleanSuiteHelper"]),
    ],
    targets: [
        .executableTarget(
            name: "CleanSuiteApp",
            dependencies: ["CleanSuiteHelper"],
            path: "CleanSuiteApp",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "CleanSuiteHelper",
            path: "CleanSuiteHelper"
        )
    ]
)
