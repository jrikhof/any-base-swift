// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "AnyBase",
    products: [
        .library(
            name: "AnyBase",
            targets: ["AnyBase"]),
    ],
    targets: [
        .target(
            name: "AnyBase",
            dependencies: []),
        .testTarget(
            name: "AnyBaseTests",
            dependencies: ["AnyBase"]),
    ]
)
