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


struct Recipe: Codable, Identifiable {
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
    
    func downloadImage() async throws {
        if self.imageURL != "" {
            let response = try await ImagePipeline.shared.image(for: URL(string: self.imageURL)!)
            let image = response.container.data
            self.imageData = image
        }
    }
}

struct Tags: Codable {
    let tagName: String
}

struct IngredientSections: Codable {
    let sectionName: String
    let sectionIngredients: [IngredientsinSection]
}

struct IngredientsinSection: Codable {
    let amount: String
    let unit: String
    let ingredient: String
}

struct Sections: Codable {
    let sectionName: String
    let sectionSteps: [Step]
}

struct Step: Codable {
    let stepInstruction: String
}

struct RecipeData: Codable {
    let cookTime: String
    let difficulty: String
    let prepTime: String
    
}
