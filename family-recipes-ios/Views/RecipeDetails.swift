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
    @State private var pickerSelection = 0
    
    var body: some View {
        
        ScrollView{
            LazyImage(url: URL(string: recipe.imageURL))
                .frame(width:400, height: 300)
                .padding(.bottom, 20)
            VStack{
                
                TitleView(recipe: recipe, colour: Color(.white))
                
                RecipeDataView(recipe: recipe)
                    .padding([.top, .bottom], 20)
                    .padding([.leading, .trailing], 30)
                
                Picker("Ingredient or Method?", selection: $pickerSelection) {
                    Text("Ingredients").tag(0)
                    Text("Method").tag(1)
                }
                .pickerStyle(.segmented)
                .padding([.top, .bottom], 20)
                .padding([.leading, .trailing], 30)
                
                if pickerSelection == 0 {
                    VStack (alignment: .leading){
                        ForEach(recipe.ingredients, id:\.self){ingredient in
                            
                            Text(ingredient.sectionName)
                                .font(Font.custom("Comfortaa", size: 20))
                                .textCase(.uppercase)
                                .padding(.bottom, 5)
                            ForEach(ingredient.sectionIngredients, id:\.self){ ingredientItem in
                                Text("\(ingredientItem.amount) \(ingredientItem.unit) \(ingredientItem.ingredient)")
                                
                                Spacer(minLength: 5)
                            }
                            
                            Spacer(minLength: 30)
                        }
                        
                        .padding([.leading, .trailing], -160)
                    }
                    .offset(y:19.5)
                    
                }else{
                    VStack (alignment: .leading) {
                        ForEach(recipe.stepsSimple, id:\.self){section in
                            VStack(alignment: .leading){
                                Text(section.sectionName)
                                    .font(Font.custom("Comfortaa", size: 20))
                                    .textCase(.uppercase)
                                    .padding(.bottom, 5)
                                
                                ForEach(Array(section.sectionSteps.enumerated()), id: \.offset) { index, element in
                                    Text("\(index + 1). \(element.stepInstruction)")
                                    Spacer(minLength: 5)
                                }
                                
                            }
                        }
                        .padding([.top, .bottom], 20)
                        .padding([.leading, .trailing], 40)
                    }
                }
                Spacer(minLength: 10)
                
                
                Text(recipe.furtherInfo)
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 20)
                    .font(.callout)
                    .background(Color(UIColor.systemGray6))
                
                HStack{
                    Text("Tags: ")
                        .italic()
                    ForEach(Array(recipe.tags.enumerated()), id: \.offset) { index, element in
                        
                        if index == recipe.tags.count - 1 {
                            Text("\(element.tagName)")
                                .italic()
                        }else{
                            Text("\(element.tagName),")
                                .italic()
                        }
                    }
                    Spacer()
                }
                .padding(20)
                
                
            
            }
        }
        .navigationTitle(recipe.title)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

struct RecipeDetails_Previews: PreviewProvider {
    static var localRecipe = ModelData().localRecipe
    static var previews: some View {
        RecipeDetails(recipe: localRecipe[0])
            .environmentObject(ModelData())
    }
}
