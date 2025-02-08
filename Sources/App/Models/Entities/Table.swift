//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Fluent
import Vapor

final class Table: Model, Content, @unchecked Sendable {
    static let schema = "tables"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "number")
    var number: Int
    
    @Field(key: "free")
    var free: Bool
    
    @OptionalParent(key: "user_id")
    var user: User?
    
    init() {}
    
    init(tableID: UUID? = nil, number: Int, free: Bool, userID: UUID? = nil) {
        self.id = tableID
        self.number = number
        self.free = free
        self.$user.id = userID
    }
}
