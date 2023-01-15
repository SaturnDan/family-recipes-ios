//
//  FavouritesView.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 15/1/2023.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationStack{
            List(modelData.favouriteRecipes){ recipe in
                NavigationLink {
                    RecipeDetails()
                } label: {
                    RecipeRow()
                }
            }
            .navigationTitle("Favourites")
                
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
            .environmentObject(ModelData())
    }
}
