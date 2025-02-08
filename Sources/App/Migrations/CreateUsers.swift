//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Fluent
import Vapor

struct CreateUsers: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("created_at", .datetime)
            .field("password", .string, .required)
            .field("name", .string, .required)
            .field("phone_id", .uuid, .required, .references("phones", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
