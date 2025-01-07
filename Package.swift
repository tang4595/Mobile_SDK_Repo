// swift-tools-version:5.3
import PackageDescription
import Foundation

struct versionInfo: Decodable {
  let version: String
  let checkSum: String
}

var AmaniSDKConfig:versionInfo = versionInfo(version: "", checkSum: "")
var AmaniVideoConfig:versionInfo = versionInfo(version: "", checkSum: "")
var AmaniVoiceAssistantSDKConfig:versionInfo = versionInfo(version: "", checkSum: "")

  let configFilePath = URL(fileURLWithPath: #file).deletingLastPathComponent()
  
  let AmaniSDKConfigData = try! Data(contentsOf: configFilePath.appendingPathComponent("VersionAmaniSDK.json"))
  AmaniSDKConfig = try! JSONDecoder().decode(versionInfo.self, from: AmaniSDKConfigData)
  
  let AmaniVideoConfigData = try! Data(contentsOf: configFilePath.appendingPathComponent("VersionAmaniVideo.json"))
  AmaniVideoConfig = try! JSONDecoder().decode(versionInfo.self, from: AmaniVideoConfigData)

  let AmaniVoiceAssistantSDKConfigData = try! Data(contentsOf: configFilePath.appendingPathComponent("VersionAmaniVoiceAssistantSDK.json"))
  AmaniVoiceAssistantSDKConfig = try! JSONDecoder().decode(versionInfo.self, from: AmaniVoiceAssistantSDKConfigData)


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
        ),
        .library(
          name:"AmaniVoiceAssistantSDK",
          targets: ["AmaniVoiceAssistantSDKBundle"]
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
        )
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
        .target(
          name: "AmaniVoiceAssistantSDKBundle",
          dependencies: ["AmaniVoiceAssistantSDK"]
        ),
        .binaryTarget(
          name: "AmaniVoiceAssistantSDK",
          url: "https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/blob/main/Carthage/AmaniVoiceAssistantSDK/\(AmaniVoiceAssistantSDKConfig.version)/AmaniVoiceAssistantSDK.xcframework.zip?raw=true",
          checksum: "\(AmaniVoiceAssistantSDKConfig.checkSum)"),
        .binaryTarget(
            name: "AmaniSDK",
            url: "https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/blob/main/Carthage/AmaniSDK/v\(AmaniSDKConfig.version)/AmaniSDK.xcframework.zip?raw=true",
            checksum: "\(AmaniSDKConfig.checkSum)"
        ),
        .binaryTarget(
            name: "AmaniVideoSDK",
            url: "https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/blob/main/Carthage/AmaniVideoSDK/\(AmaniVideoConfig.version)/AmaniVideoSDK.xcframework.zip?raw=true",
            checksum: "\(AmaniVideoConfig.checkSum)"
        ),
        .target(
            name: "AmaniVideoBundle",
            dependencies: [
                    "AmaniVideoSDK",
                    "SocketIO",
                    "WebRTC"
                ]
        )
    ]
)
