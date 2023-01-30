//
//  RecipeTagItem.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 26/1/2023.
//

import SwiftUI
import NukeUI
import Nuke

struct RecipeTagItem: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyImage(url: URL(string: recipe.imageURL))
                .frame(width: 155, height: 155)
                .cornerRadius(10)
            
            Text(recipe.title)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .padding(8)
    }
}

struct RecipeTagItem_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTagItem(recipe: ModelData().localRecipe[0])
    }
}
