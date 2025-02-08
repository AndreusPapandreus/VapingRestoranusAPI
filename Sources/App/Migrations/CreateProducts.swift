//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Vapor
import Fluent

struct CreateProducts: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(Product.schema)
            .id()
            .field("name", .string, .required)
            .field("price", .double, .required)
            .field("description", .string, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(Product.schema).delete()
    }
}
