// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import AVFoundation

let package = Package(
    name: "Community",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Community",
            targets: ["Community"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
       // .package(url: "../Community", from: "1.0.0"),
        .package(url: "https://github.com/instaply/MobileVLCKit.git", from: "3.4.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Community",
            dependencies: ["MobileVLCKit"]//,
            //resources: [.process("Resources")]
        ),
        .testTarget(
            name: "CommunityTests",
            dependencies: ["Community"]),
    ]
)
