//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 07.02.2025.
//

import Vapor
import JWT

struct Payload: JWTPayload, Authenticatable {
    var name: String
    var phone: UUID
    
    var exp: ExpirationClaim
    
    func verify(using algorithm: some JWTAlgorithm) async throws {
        try self.exp.verifyNotExpired()
    }
    
    init(with user: User) throws {
        self.name = user.name
        self.phone = user.$phone.id
        self.exp = ExpirationClaim(value: Date().addingTimeInterval(Constants.ACCESS_TOKEN_LIFETIME))
    }
}
