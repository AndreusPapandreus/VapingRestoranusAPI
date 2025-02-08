//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 07.02.2025.
//

import Vapor
import RegexBuilder
import Fluent

final class User: Model, @unchecked Sendable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "name")
    var name: String
    
    @Parent(key: "phone_id")
    var phone: Phone
    
    @OptionalChild(for: \.$user)
    var table: Table?
    
    init() {}
    init(id: UUID? = nil, name: String, password: String, phoneID: UUID) {
        self.id = id
        self.createdAt = nil
        self.password = password
        self.name = name
        self.$phone.id = phoneID
    }
}

extension User: Authenticatable {}

