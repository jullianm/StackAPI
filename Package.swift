// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StackAPI",
    platforms: [
        // Add support for all platforms starting from a specific version.
        .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "StackAPI",
            targets: ["StackAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "StackAPI",
            dependencies: ["KeychainAccess"]
        ),
        .testTarget(
            name: "StackAPITests",
            dependencies: ["StackAPI"],
            resources: [.copy("Answers.json"),
                        .copy("Comments.json"),
                        .copy("Inbox.json"),
                        .copy("Posts.json"),
                        .copy("Questions.json"),
                        .copy("Search.json"),
                        .copy("Tags.json"),
                        .copy("Timeline.json"),
                        .copy("User.json")]),
    ]
)
