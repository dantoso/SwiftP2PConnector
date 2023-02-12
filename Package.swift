// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftP2PConnector",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftP2PConnector",
            targets: ["SwiftP2PConnector"]),
		.library(
			name: "MultipeerConnectivity",
			targets: ["SwiftP2PConnector"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
		.package(path: "MultipeerConnectivity")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftP2PConnector",
            dependencies: []),
        .testTarget(
            name: "SwiftP2PConnectorTests",
            dependencies: ["SwiftP2PConnector"]),
    ]
)
