import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vape",
        password: Environment.get("DATABASE_PASSWORD") ?? "is_bad",
        database: Environment.get("DATABASE_NAME") ?? "restaurant",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    await app.jwt.keys.add(hmac: HMACKey(from: Environment.get("JWT_KEY") ?? "secret"), digestAlgorithm: .sha256)
    
    try migrations(app)
    try app.autoMigrate().wait()
    
    try routes(app)
}
