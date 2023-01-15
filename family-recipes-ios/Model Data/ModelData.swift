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
    let saveKey = "allRecipe"
    let favSaveKey = "favouriteRecipe"
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(favouriteRecipes) {
            UserDefaults.standard.set(encoded, forKey: favSaveKey)
        }
        if let encoded = try? JSONEncoder().encode(recipeList) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: favSaveKey) {
            if let decoded = try? JSONDecoder().decode([Recipe].self, from: data) {
                favouriteRecipes = decoded
            }
        }
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Recipe].self, from: data) {
                recipeList = decoded
            }
        }
        clearDefaults()
    }
    
    func appendFav(newRecipe: Recipe){
        self.favouriteRecipes.append(newRecipe)
    }
    
    func removeFav(recipeName: String){
        if let index = self.favouriteRecipes.firstIndex(where: {$0.recipeName == recipeName}){
            self.favouriteRecipes.remove(at: index)
        }
    }
    
    func clearDefaults(){
        UserDefaults.standard.removeObject(forKey: saveKey)
        UserDefaults.standard.removeObject(forKey: favSaveKey)
        UserDefaults.standard.synchronize()
    }
    
    func loadAllRecipes() {
        let url = URL(string: "https://0hgyyrn329.execute-api.ap-southeast-2.amazonaws.com/v1/recipes/list")
        
        //Get list of all recipe names
        AF.request(url!, method: .get).validate().responseDecodable(of: RecipeNameList.self){ response in
            switch response.result{
                
            //If success, get recipe for each name
            case .success(let value):
                let RecipeList = value.recipeNames
                RecipeList.forEach { name in
                    self.getRecipe(recipeName: name.recipeName.s, completionHandler: {result in
                        switch result{
                        case .success(let value):
                            //If get recipe success, append to the list of recipes in modelData
                            if self.recipeList.contains(where: {$0.recipeName == value.recipeName}){
                                debugPrint("Recipe already in list")
                            }else{
                                self.recipeList.append(value)
                            }
                           
                        case.failure(let error):
                            print(error.localizedDescription)
                        }
                    })
                }
                
            case .failure(let error):
                debugPrint(error)
               //completionHandler(.failure(error))
                
            }
        }
        
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
                        let ingAmount = tempIng.m.amount.s
                        let ingUnit = tempIng.m.unit.s
                        let ingName = tempIng.m.ingredient.s
                        
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
                let newRecipe = Recipe(recipeName: tempRecipe.recipeName.s, description: descriptionString, shortDescription: tempRecipe.shortDescription.s, ingredients: tempIngredients, imageURL: tempRecipe.image.s, tags: newTags, stepsSimple: tempSimpleSteps, stepsDetailed: tempDetailSteps, recipeData: recipeData, title: tempRecipe.title.s, furtherInfo: furtherInfo)
                
                //Append new recipe to list
                //self.recipeList.append(newRecipe)
                
                //Send back new recipe
                completionHandler(.success(newRecipe))
                
            case .failure(let error):
                debugPrint(error)
                completionHandler(.failure(error))
            }
        }
        
    }
}
