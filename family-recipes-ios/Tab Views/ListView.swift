//
//  ListView.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 15/1/2023.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var isLoading = true

    
    var body: some View {
        
        NavigationStack{
            List(modelData.recipeList){ recipe in
                NavigationLink {
                    RecipeDetails(recipe: recipe)
                } label: {
                    RecipeRow(recipe: recipe)
                }
                .redacted(reason: isLoading ? .placeholder : .init())
            }
            .navigationTitle("Recipes")
        }
       
        .onAppear{
            modelData.loadAllRecipes(completionHandler: { result in
                switch result {
                case .success(_):
                    debugPrint("Recipes successfully retrieved")

                    isLoading = false
                case .failure(let r):
                    print(r.localizedDescription)
                    isLoading = false
                }
            })
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ModelData())
    }
}
