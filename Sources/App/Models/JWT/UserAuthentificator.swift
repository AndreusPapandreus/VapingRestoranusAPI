//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Vapor
import Fluent
import JWT

struct UserAuthenticator: JWTAuthenticator {
    typealias Payload = App.Payload
    
    func authenticate(jwt: Payload, for request: Request) async throws {
        guard let user = try await User.query(on: request.db)
            .join(Phone.self, on: \User.$phone.$id == \Phone.$id)
            .filter(Phone.self, \.$id == jwt.phone)
            .first()
        else {
            throw Abort(.unauthorized, reason: "No user with this phone number exists.")
        }
        request.auth.login(user)
    }
}
