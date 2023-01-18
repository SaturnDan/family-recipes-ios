//
//  RecipeDetails.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 16/1/2023.
//

import SwiftUI
import NukeUI

struct RecipeDetails: View {
    @EnvironmentObject var modelData: ModelData
    var recipe: Recipe
    
    var body: some View {
        
        ScrollView{
            LazyImage(url: URL(string: recipe.imageURL))
                .frame(width:400, height: 300)
                .padding(.bottom, 20)
            VStack{
                
                TitleView(recipe: recipe, colour: Color(.white))
                
                RecipeDataView(recipe: recipe)
                    .padding(20)
                
                DisclosureGroup{
                    Spacer(minLength: 20)
                    HStack(alignment: .top){
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
                        }
                    }
                    
                } label: {
                    Text("Ingredients")
                        .frame(alignment:.leading)
                        .font(.title2)
                }
                .foregroundColor(.black)
                .padding(20)
                .background(Color(.white))
                .tint(.black)
                
                Text(recipe.furtherInfo)
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 20)
                    .font(.callout)
                
                
                /*
                ViewThatFits(in: .horizontal){
                    HStack{
                        ForEach(recipe.tags, id:\.self){ tag in
                            
                            Tag(title: tag.tagName, backgroundColour: tag.tagColour)
                        }
                        
                    }
                    VStack{
                        ForEach(recipe.tags, id:\.self){ tag in
                            Tag(title: tag.tagName, backgroundColour: tag.tagColour)
                        }
                    }
                 
                }
                 */
                HStack{
                    Text("Tags: ")
                        .italic()
                    ForEach(recipe.tags, id:\.self){ tag in
                            Text("\(tag.tagName),")
                            .italic()
                    }
                    Spacer()
                }
                .padding(20)
                
            }
        }
    }
    
}

struct RecipeDetails_Previews: PreviewProvider {
    static var localRecipe = ModelData().localRecipe
    static var previews: some View {
        RecipeDetails(recipe: localRecipe[0])
            .environmentObject(ModelData())
    }
}
