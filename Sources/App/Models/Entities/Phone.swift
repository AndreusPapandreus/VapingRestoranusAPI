//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 07.02.2025.
//

import Fluent
import Vapor

final class Phone: Model, Content, @unchecked Sendable {
    static let schema = "phones"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "value")
    var value: String
    
    init() {}
    init(id: UUID? = nil, value: String) {
        self.id = id
        self.value = value
    }
}
