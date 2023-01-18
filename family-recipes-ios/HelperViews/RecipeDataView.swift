//
//  RecipeDataView.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 18/1/2023.
//

import SwiftUI

struct RecipeDataView: View {
    var recipe: Recipe
    var body: some View {
        HStack(alignment: .top){
            
            //Prep Time
            VStack {
                Text("Prep time")
                    .padding(.bottom, 3)
                Text(recipe.recipeData.prepTime)
            }
            Spacer()
            Divider()
            Spacer()
            //Cook Time
            VStack{
                Text("Cook time")
                    .padding(.bottom, 3)
                Text(recipe.recipeData.cookTime)
            }
            Spacer()
            Divider()
            Spacer()
            //Difficulty
            VStack{
                Text("Difficulty")
                DifficultyScale(difficulty: recipe.recipeData.difficulty)
            }
        }
    }
}

struct RecipeDataView_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        RecipeDataView(recipe: modelData.localRecipe[0])
    }
}
