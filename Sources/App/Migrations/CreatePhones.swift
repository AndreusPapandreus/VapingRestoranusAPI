//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Fluent
import Vapor

struct CreatePhones: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("phones")
            .id()
            .field("value", .string, .required)
            .unique(on: "value")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("phones").delete()
    }
}
