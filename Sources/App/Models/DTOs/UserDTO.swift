//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Vapor

extension User {
    struct Create: Content, Validatable {
        var name: String
        var phone: String
        var password: String
        var confirmPassword: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("name", as: String.self, is: !.empty)
            validations.add("phone", as: String.self, is: Validator.phoneNumber)
            validations.add("password", as: String.self, is: .count(5...))
        }
    }
    
    struct Login: Content, Validatable {
        var phone: String
        var password: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("phone", as: String.self, is: Validator.phoneNumber)
            validations.add("password", as: String.self, is: .count(5...))
        }
    }
}
