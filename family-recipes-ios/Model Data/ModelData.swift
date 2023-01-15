//
//  ModelData.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 15/1/2023.
//

import Foundation
import Combine
import UIKit
import SwiftUI
import Alamofire

final class ModelData: ObservableObject {
    @Published var recipeList = [Recipe]()
    @Published var favouriteRecipes = [Recipe]()
    let saveKey = "SaveData"
    
    func saveData() {
        
    }
    
    func loadData(){
        clearDefaults()
    }
    
    func clearDefaults(){
        UserDefaults.standard.removeObject(forKey: saveKey)
        UserDefaults.standard.synchronize()
    }
    
    func getRecipe(recipeName: String, completionHandler: @escaping (Result<Recipe, AFError>) -> Void) {
        //Set URL
        let url = URL(string: "https://0hgyyrn329.execute-api.ap-southeast-2.amazonaws.com/v1/recipes/\(recipeName)")
        
        AF.request(url!, method: .get).validate().responseDecodable(of: TransformerRecipe.self)
        { response in
            switch response.result {
            case .success(let value):
                let tempRecipe = value.items[0]
                
                
                //Convert multiple strings in description to one string
                var descriptionString: String = ""
                tempRecipe.description.l.forEach { desc in
                    descriptionString = "\(descriptionString)\n\(desc.s)"
                }
                
                //Concatenate further info
                var furtherInfo: String = ""
                tempRecipe.furtherInfo.l.forEach {
                    info in
                    furtherInfo = "\(furtherInfo)\n\(info.s)"
                }
                
                //Create RecipeData
                let recipeData = RecipeData(cookTime: tempRecipe.data.m.cookTime.s, difficulty: tempRecipe.data.m.difficulty.s, prepTime: tempRecipe.data.m.prepTime.s)
                
                //Create temp tags
                var newTags = [Tags]()
                tempRecipe.tags.l.forEach{
                    tag in
                    newTags.append(Tags(tagName: tag.s))
                }
                
                //Create temp ingredients
                var tempIngredients = [IngredientSections]()
                
                tempRecipe.ingredients.l.forEach { ingredient in
                    var ingList = [IngredientsinSection]()
                    
                    ingredient.m.sectionIngredients.l.forEach { tempIng in
                        var ingAmount = tempIng.m.amount.s
                        var ingUnit = tempIng.m.unit.s
                        var ingName = tempIng.m.ingredient.s
                        
                        ingList.append(IngredientsinSection(amount: ingAmount, unit: ingUnit, ingredient: ingName))
                        
                    }
                    tempIngredients.append(IngredientSections(sectionName: ingredient.m.sectionName.s, sectionIngredients: ingList))
                }
                
                
                //Create temp simple steps
                var tempSimpleSteps = [Sections]()
                
                tempRecipe.stepsSimple.l.forEach { steps in
                    var stepList = [Step]()
                    
                    steps.m.sectionSteps.l.forEach { stepDescription in
                        stepList.append(Step(stepInstruction: stepDescription.s))
                    }
                    
                    tempSimpleSteps.append(Sections(sectionName: steps.m.sectionName.s, sectionSteps: stepList))
                }
                
                //Create temp detailed steps
                var tempDetailSteps = [Sections]()
                tempRecipe.stepsDetailed.l.forEach { steps in
                    var stepList = [Step]()
                    
                    steps.m.sectionSteps.l.forEach { stepDescription in
                        stepList.append(Step(stepInstruction: stepDescription.s))
                    }
                    
                    tempDetailSteps.append(Sections(sectionName: steps.m.sectionName.s, sectionSteps: stepList))
                }
                
                //Create new recipe from data
                var newRecipe = Recipe(recipeName: tempRecipe.recipeName.s, description: descriptionString, shortDescription: tempRecipe.shortDescription.s, ingredients: tempIngredients, imageURL: tempRecipe.image.s, tags: newTags, stepsSimple: tempSimpleSteps, stepsDetailed: tempDetailSteps, recipeData: recipeData, title: tempRecipe.title.s, furtherInfo: furtherInfo)
                
                //Append new recipe to list
                self.recipeList.append(newRecipe)
                
                //Send back new recipe
                completionHandler(.success(newRecipe))
                
            case .failure(let error):
                debugPrint(error)
                completionHandler(.failure(error))
            }
        }
        
    }
}
