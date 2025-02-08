//
//  File.swift
//  Restaurant
//
//  Created by Андрій on 08.02.2025.
//

import Vapor

func migrations(_ app: Application) throws {
    app.migrations.add(CreatePhones())
    app.migrations.add(CreateUsers())
    app.migrations.add(CreateTables())
    app.migrations.add(CreateIngredients())
    app.migrations.add(CreateProducts())
    app.migrations.add(CreateProductIngredients())
}
