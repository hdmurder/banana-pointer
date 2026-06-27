// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "BananaPointer",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "BananaPointer", targets: ["BananaPointer"])
    ],
    targets: [
        .executableTarget(
            name: "BananaPointer",
            path: "Sources/BananaPointer"
        )
    ]
)
