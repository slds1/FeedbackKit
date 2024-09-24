// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "FeedbackKit",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "FeedbackKit",
            targets: ["FeedbackKit"]),
    ],
    targets: [
        .target(
            name: "FeedbackKit",
            dependencies: [],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
