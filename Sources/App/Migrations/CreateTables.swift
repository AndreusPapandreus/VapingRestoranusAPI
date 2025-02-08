//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Fluent
import Vapor

struct CreateTables: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("tables")
            .id()
            .field("number", .int, .required)
            .field("free", .bool, .required)
            .field("user_id", .uuid)
            .foreignKey("user_id", references: "users", "id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("tables").delete()
    }
}
