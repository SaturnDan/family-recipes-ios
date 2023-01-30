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
    let tagName: String
    var tagColour: Color {
        switch tagName {
        case "favourites": return Color(UIColor("#f7dc6f"))
        case "italian": return Color(UIColor("#58d68d"))
        case "pizza": return Color(UIColor("#ff7b7b"))
        default: return Color(UIColor.systemGray5)
        }
    }
}

struct IngredientSections: Codable, Hashable {
    let sectionName: String
    let sectionIngredients: [IngredientsinSection]
}

struct IngredientsinSection: Codable, Hashable {
    let amount: String
    let unit: String
    let ingredient: String
}

struct Sections: Codable, Hashable {
    let sectionName: String
    let sectionSteps: [Step]
}

struct Step: Codable, Hashable {
    let stepInstruction: String
}

struct RecipeData: Codable, Hashable {
    let cookTime: String
    let difficulty: String
    let prepTime: String
    
}
