//
//  RecipeTagListView.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 26/1/2023.
//

import SwiftUI
import NukeUI
import Nuke

struct RecipeTagListView: View {
    var tagName: String
    var recipes: [Recipe]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(tagName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView (.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 0) {
                    
                    ForEach(recipes) { recipe in
                        NavigationLink {
                            RecipeDetails(recipe: recipe)
                        } label: {
                            RecipeTagItem(recipe: recipe)
                        }
                        
                    }
                }
            }
            .frame(height: 185)
            
        }
        .padding([.bottom, .top], 10)
    }
}

struct RecipeTagListView_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        RecipeTagListView(tagName: "Test Tag", recipes:  modelData.localRecipe)
    }
}
