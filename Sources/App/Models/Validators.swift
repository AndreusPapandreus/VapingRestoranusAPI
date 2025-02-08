//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Vapor
import RegexBuilder

extension ValidatorResults {
    public struct PhoneNumber {
        public let isValidPhone: Bool
    }
}

extension ValidatorResults.PhoneNumber: ValidatorResult {
    public var isFailure: Bool {
        !self.isValidPhone
    }

    public var successDescription: String? {
        "is a valid phone number"
    }

    public var failureDescription: String? {
        "is not a valid phone number"
    }
}

extension Validator where T == String {

    public static var phoneNumber: Validator<T> {
        .init { input in
            let regex = #"^\+\d{2}\(\d{3}\)\d{3}-\d{2}-\d{2}$"#
            guard let range = input.range(of: regex, options: [.regularExpression]),
                  range.lowerBound == input.startIndex && range.upperBound == input.endIndex
            else {
                return ValidatorResults.PhoneNumber(isValidPhone: false)
            }
            return ValidatorResults.PhoneNumber(isValidPhone: true)
        }
    }
}
