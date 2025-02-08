//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Vapor
import Fluent

final class ProductIngredient: Model {
    static let schema = "product_ingredients"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "product_id")
    var product: Product
    
    @Parent(key: "ingredient_id")
    var ingredient: Ingredient
    
    init() { }
    
    init(id: UUID? = nil, productID: UUID, ingredientID: UUID) {
        self.id = id
        self.$product.id = productID
        self.$ingredient.id = ingredientID
    }
}
