//
//  IngredientList.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 19/1/2023.
//

import SwiftUI

struct IngredientList: View {
    var recipe: Recipe
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(recipe.ingredients, id:\.self){ingredient in
                VStack(alignment: .leading){
                    Text(ingredient.sectionName)
                        .font(Font.custom("Comfortaa", size: 20))
                        .textCase(.uppercase)
                        .padding(.bottom, 5)
                        
                    
                    ForEach(ingredient.sectionIngredients, id:\.self){ ingredientItem in
                        
                        Text("\(ingredientItem.amount) \(ingredientItem.unit) \(ingredientItem.ingredient)")
                            
                        Spacer(minLength: 5)
                    }
                }
                Spacer(minLength: 50)
            }
           
        }
        .transition(.move(edge: .top))
    }
}

struct IngredientList_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        IngredientList(recipe: modelData.localRecipe[0])
    }
}
