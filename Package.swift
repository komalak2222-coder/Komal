// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "OGManager",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "OGManager", targets: ["OGManager"])
    ],
    targets: [
        .executableTarget(
            name: "OGManager",
            path: "Sources"
        )
    ]
)
