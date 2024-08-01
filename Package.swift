// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "reelsView",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "reelsView",
            targets: ["reelsView"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "reelsView",
        dependencies: []),
        .testTarget(
            name: "reelsViewTests",
            dependencies: ["reelsView"]),
    ]
)
