//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Vapor
import Fluent

struct CreateProductIngredients: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(ProductIngredient.schema)
            .id()
            .field("product_id", .uuid, .required)
            .field("ingredient_id", .uuid, .required)
            .foreignKey("product_id", references: Product.schema, "id", onDelete: .cascade, onUpdate: .cascade)
            .foreignKey("ingredient_id", references: Ingredient.schema, "id", onDelete: .cascade, onUpdate: .cascade)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(ProductIngredient.schema).delete()
    }
}
