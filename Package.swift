// swift-tools-version:5.3
import PackageDescription

let CoreVersion = "3.4.1"
let UIVersion = "1.1.8"
let VideoVersion = "2.0.1"

let package = Package(
    name: "AmaniRepo",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AmaniSDK",
            targets: ["AmaniSDKBundle"]
        ),
        .library(
            name:"AmaniVideoSDK",
            targets: ["AmaniVideoBundle"]
        )
    ],
    dependencies: [
        .package(
            name: "OpenSSL",
            url: "https://github.com/krzyzanowskim/OpenSSL.git",
            .upToNextMinor(from: "1.1.2300")
        ),
        .package(
            name: "SocketIO",
            url:    "https://github.com/socketio/socket.io-client-swift.git",
            .upToNextMinor(from: "16.1.0")
        ),
        .package(
            name:   "WebRTC",
            url: "https://github.com/stasel/WebRTC.git",
            .upToNextMinor(from: "127.0.0")
        ),
    ],
    targets: [
        .target(
            name: "AmaniSDKBundle",
            dependencies: [
                    "AmaniSDK",
                    "OpenSSL"
                ],
            linkerSettings:[
              .linkedFramework("CryptoKit"),
              .linkedFramework("CoreNFC"),
              .linkedFramework("CryptoTokenKit"),
            ]
        ),
        .binaryTarget(
            name: "AmaniSDK",
            url: "https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/blob/main/Carthage/AmaniSDK/v\(CoreVersion)/AmaniSDK.xcframework.zip?raw=true",
            checksum: "b9ed75d9dd6183e8edd10f7f5e31be28936a299dac3dfd394ca0d7ada10e6977"
        ),
        .binaryTarget(
            name: "AmaniVideoSDK",
            url: "https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/blob/main/Carthage/AmaniVideoSDK/\(VideoVersion)/AmaniVideoSDK.xcframework.zip?raw=true",
            checksum: "538fc22d952ee10496a8fce900969f55c992767483d487e0d2dd0a454b43e30d"
        ),
        .target(
            name: "AmaniVideoBundle",
            dependencies: [
                    "AmaniVideoSDK",
                    "SocketIO",
                    "WebRTC"
                ]
        ),    
    ]
)

