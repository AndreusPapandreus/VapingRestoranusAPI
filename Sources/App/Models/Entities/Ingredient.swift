//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 07.02.2025.
//

import Vapor
import Fluent

final class Ingredient: Model, Content {
    static let schema = "ingredients"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Siblings(through: ProductIngredient.self, from: \.$ingredient, to: \.$product)
    var products: [Product]
    
    init() { }
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
