//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 07.02.2025.
//

import Fluent
import Vapor

final class Product: Model, Content {
    static let schema = "products"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "price")
    var price: Double
    
    @Field(key: "description")
    var description: String
    
    @Siblings(through: ProductIngredient.self, from: \.$product, to: \.$ingredient)
    var ingredients: [Ingredient]
    
    init() { }
    
    init(id: UUID? = nil, name: String, price: Double, description: String) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
    }
}
