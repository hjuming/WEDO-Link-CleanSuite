// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CleanSuite",
    defaultLocalization: "en",
    platforms: [ .macOS(.v13) ],
    products: [.executable(name: "CleanSuite", targets: ["CleanSuite"])],
    dependencies: [
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.5.0")
    ],
    targets: [
        .executableTarget(
            name: "CleanSuite",
            dependencies: [
                .product(name: "Sparkle", package: "Sparkle")
            ],
            path: "CleanSuiteApp"
        )
    ]
)
