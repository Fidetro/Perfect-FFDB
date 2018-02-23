import PackageDescription


let package = Package(
    name: "PerfectFFDB",
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 3),
           .Package(url: "https://github.com/PerfectlySoft/Perfect-Logger.git",majorVersion: 3)
    ],
    exclude:[]
)
