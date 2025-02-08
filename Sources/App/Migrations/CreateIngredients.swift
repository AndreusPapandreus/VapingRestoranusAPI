//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Vapor
import Fluent

struct CreateIngredients: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(Ingredient.schema)
            .id()
            .field("name", .string, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(Ingredient.schema).delete()
    }
}
