//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Vapor

extension Table {
    struct Reserved: Content, Validatable {
        var number: Int
        
        static func validations(_ validations: inout Validations) {
            validations.add("number", as: Int.self, is: .range(1...))
        }
    }
}
