//
//  TitleView.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 16/1/2023.
//

import SwiftUI
import NukeUI

struct TitleView: View {
    var recipe: Recipe
    var colour: Color
    
    var body: some View {
        
        VStack (alignment: .center){
            Text(recipe.title)
                .font(Font.custom("Comfortaa", size: 25))
                .bold()
            
            VStack (alignment: .leading){
                Text("Description")
                    .font(.headline)

                    .foregroundColor(Color(UIColor("#2e4053")))
                    .padding(.bottom, 1)
                
                Text(recipe.shortDescription)
                    
            }
            .padding(20)
           
            
            
        }
        
    }
    
}

struct TitleView_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        TitleView(recipe: modelData.localRecipe[0], colour: Color(UIColor.systemGray5))
    }
}
