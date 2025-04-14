
// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "BaseNetwork",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BaseNetwork",
            targets: ["BaseNetwork"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.0") // ✅ Alamofire bağımlılığı
    ],
    targets: [
        .target(
            name: "BaseNetwork",
            dependencies: ["Alamofire"], // ✅ Hedefe bağlıyoruz
            path: "Sources/BaseNetwork"
        )
    ]
)

