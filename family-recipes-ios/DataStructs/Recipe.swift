//
//  Recipe.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 15/1/2023.
//

import Foundation
import SwiftUI
import Nuke
import Alamofire
import Combine
import UIColorHexSwift


struct Recipe: Codable, Identifiable, Hashable {
    var id = UUID()
    let recipeName: String
    let description: String
    let shortDescription: String
    let ingredients: [IngredientSections]
    let imageURL: String
    let tags: [Tags]
    let stepsSimple: [Sections]
    let stepsDetailed: [Sections]
    let recipeData: RecipeData
    let title: String
    let furtherInfo: String
    var imageData: Data?
    var isFavourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, recipeName, description, shortDescription, ingredients, imageURL, tags, stepsSimple, stepsDetailed, recipeData, title, furtherInfo, imageData
    }
    
    
    init(description: String, shortDescription: String, stepsDetailed: [Sections], tags: [Tags], stepsSimple: [Sections], furtherInfo: String, title: String, ingredients: [IngredientSections], imageURL: String, recipeData: RecipeData, recipeName: String, isFavourite: Bool = false) {
            self.id = UUID()
            self.description = description
            self.shortDescription = shortDescription
            self.stepsDetailed = stepsDetailed
            self.tags = tags
            self.stepsSimple = stepsSimple
            self.furtherInfo = furtherInfo
            self.title = title
            self.ingredients = ingredients
            self.imageURL = imageURL
            self.recipeData = recipeData
            self.recipeName = recipeName
            self.isFavourite = isFavourite
        }
}

struct Tags: Codable, Hashable {
    var tagName: String
}

struct IngredientSections: Codable, Hashable {
    var sectionName: String
    var sectionIngredients: [IngredientsinSection]
}

struct IngredientsinSection: Codable, Hashable {
    var amount: String
    var unit: String
    var ingredient: String
}

struct Sections: Codable, Hashable {
    var sectionName: String
    var sectionSteps: [Step]
}

struct Step: Codable, Hashable {
    var stepInstruction: String
}

struct RecipeData: Codable, Hashable {
    let cookTime: String
    let difficulty: String
    let prepTime: String
    
}
