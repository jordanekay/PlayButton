// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "PlayButton",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "PlayButton",
            targets: ["PlayButton"]
        )
    ],
    targets: [.target(name: "PlayButton")],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .enableExperimentalFeature("StrictConcurrency"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault")
    ]
}

