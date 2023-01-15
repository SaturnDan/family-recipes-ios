//
//  RecipeNames.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 16/1/2023.
//

import Foundation

// MARK: - Welcome
struct RecipeNameList: Codable, Equatable {
    var count: Int
    var recipeNames: [RecipeNames]
    var scannedCount: Int

    enum CodingKeys: String, CodingKey {
        case count = "Count"
        case recipeNames = "Items"
        case scannedCount = "ScannedCount"
    }
}

// MARK: - Item
struct RecipeNames: Codable, Equatable {
    var recipeName: RecipeString
}


struct RecipeString: Codable, Equatable {
    var s: String

    enum CodingKeys: String, CodingKey {
        case s = "S"
    }
}

