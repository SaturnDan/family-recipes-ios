//
//  RecipeRow.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 16/1/2023.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        Text("\(recipe.recipeName)")
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var localRecipe = ModelData().localRecipe
    static var previews: some View {
        RecipeRow(recipe: localRecipe[0])
    }
}
