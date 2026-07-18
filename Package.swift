// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SafariSheetKit",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SafariSheetKit",
            targets: ["SafariSheetKit"]
        )
    ],
    targets: [
        .target(name: "SafariSheetKit"),
        .testTarget(
            name: "SafariSheetKitTests",
            dependencies: ["SafariSheetKit"]
        )
    ]
)
