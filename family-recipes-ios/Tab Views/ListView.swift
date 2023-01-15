//
//  ListView.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 15/1/2023.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        
        NavigationStack{
            List(modelData.recipeList){ recipe in
                NavigationLink {
                    RecipeDetails()
                } label: {
                    RecipeRow()
                }
            }
            .navigationTitle("Recipes")
                
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ModelData())
    }
}
