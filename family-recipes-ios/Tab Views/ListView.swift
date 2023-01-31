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
    @State private var showingForm = false
    
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                if modelData.featuredRecipe != nil {
                    
                    NavigationLink {
                        RecipeDetails(recipe: modelData.featuredRecipe!)
                    } label: {
                        FeatureRecipe(recipe: modelData.featuredRecipe!)
                    }
                }
                
                if modelData.favouriteRecipes.count > 0 {
                    RecipeTagListView(tagName: "Favourites", recipes: modelData.favouriteRecipes)
                }
                
                
                ForEach(modelData.recipeTags.keys.sorted(), id: \.self) { key in
                    RecipeTagListView(tagName: key.capitalized, recipes: modelData.recipeTags[key]!)
                }
                .listRowInsets(EdgeInsets())
                
                List(modelData.recipeList){ recipe in
                    NavigationLink {
                        RecipeDetails(recipe: recipe)
                    } label: {
                        RecipeRow(recipe: recipe)
                    }
                    .redacted(reason: isLoading ? .placeholder : .init())
                }
                
            }
            
            .navigationTitle("Recipes")
            .listStyle(.inset)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingForm.toggle()
                    } label: {
                        HStack{
                            Text("Add")
                            Image(systemName: "doc.badge.plus")
                                .tint(.blue)
                        }
                    }
                    .sheet(isPresented: $showingForm) {
                                RecipeForm()
                            }
                }
            }
        }
        
        .onAppear{
            modelData.loadAllRecipes(completionHandler: { result in
                switch result {
                case .success(_):
                    
                    
                    print("Successfully loaded recipes")
                case .failure(let r):
                    print(r.localizedDescription)
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
