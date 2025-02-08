//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 07.02.2025.
//

import Vapor
import Fluent

struct RestaurantController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        let protected = api.grouped(UserAuthenticator())

        api.post("signup", use: signup)
        api.post("login", use: login)
        api.get("greeting", use: publicGreeting)

        protected.get("tables", use: getTables)
        protected.post("reserve", use: reserveTable)
    }

    // MARK: - Public
    
    @Sendable
    func publicGreeting(req: Request) async throws -> String {
        "Hello from Andrewsha Restaurant!"
    }

    @Sendable
    func signup(req: Request) async throws -> [String: String] {
        let user = try req.content.decode(User.Create.self)
        try User.Create.validate(content: req)
        
        let passwordHash = try Bcrypt.hash(user.password)
        if let existingPhone = try await Phone.query(on: req.db)
            .filter(\Phone.$value == user.phone)
            .first()
        {
            throw Abort(.conflict, reason: "This phone number is already taken.")
        }
        let phone = Phone(value: user.phone)
        try await phone.save(on: req.db)
        let newUser = User(name: user.name, password: passwordHash, phoneID: try phone.requireID())
        try await newUser.save(on: req.db)

        let payload = try Payload(with: newUser)
        let token = try await req.jwt.sign(payload)
        return ["token": token]
    }

    @Sendable
    func login(req: Request) async throws -> [String: String] {
        let data = try req.content.decode(User.Login.self)
        try User.Login.validate(content: req)

        guard let user = try await User.query(on: req.db)
            .join(Phone.self, on: .join(
                schema: "phones",
                alias: nil,
                DatabaseQuery.Join.Method.inner,
                foreign: .path(["phone_id"], schema: "users"),
                local:   .path(["id"],       schema: "phones")
            ))
            .filter(Phone.self, \.$value == data.phone)
            .first()
        else {
            throw Abort(.unauthorized, reason: "User not found with phone: \(data.phone).")
        }
        
        guard try Bcrypt.verify(data.password, created: user.password) else {
            throw Abort(.unauthorized, reason: "Invalid password.")
        }

        let payload = try Payload(with: user)
        let token = try await req.jwt.sign(payload)
        return ["token": token]
    }
    
    // MARK: - Private
    
    @Sendable
    func getTables(req: Request) async throws -> [Int] {
        let tables = try await Table.query(on: req.db)
            .filter(\.$free == true)
            .all()
        let tableNums = try tables.map { try $0.number }
        return tableNums
    }
    
    @Sendable
    func reserveTable(req: Request) async throws -> [String: String] {
        let user = try req.auth.require(User.self)
        let data = try req.content.decode(Table.Reserved.self)
        try Table.Reserved.validate(content: req)
        guard let table = try await Table.query(on: req.db)
            .filter(\.$free == true)
            .filter(Table.self, \.$number == data.number)
            .first()
        else { throw Abort(.expectationFailed, reason: "Table is already taken.") }
        
        table.$user.id = try user.requireID()
        table.free = false
        try await table.update(on: req.db)
        
        return ["your_table": "\(table.number)"]
    }
}
