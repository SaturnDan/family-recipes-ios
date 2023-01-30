//
//  FeatureRecipe.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 26/1/2023.
//

import SwiftUI
import Nuke
import NukeUI

struct FeatureRecipe: View {
    var recipe: Recipe
    var body: some View {
        LazyImage(url: URL(string: recipe.imageURL))
            .aspectRatio(1.5, contentMode: .fit)
            .overlay{
                TextOverlay(recipe: recipe)
            }
    }
}

struct TextOverlay: View {

    var recipe: Recipe

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.8), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }


    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                
                Text(recipe.title)
                    .font(.title)
                    .bold()
                
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeatureRecipe_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        FeatureRecipe(recipe: modelData.localRecipe[0])
    }
}
