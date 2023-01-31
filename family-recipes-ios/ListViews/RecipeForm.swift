//
//  RecipeForm.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 30/1/2023.
//

import SwiftUI

struct RecipeForm: View {
    @State var name: String = ""
    @State var title: String = ""
    @State var shortDescription: String = ""
    @State var description: String = ""
    @State var furtherInfo: String = ""
    @State var cookTime: String = ""
    @State var prepTime: String = ""
    @State var imageURL: String = ""
    @State private var difficultyIndex: Int = 0
    @State var tags = [Tags]()
    @State var simpleStepSections = [Sections]()
    @State var detailedStepSections = [Sections]()
    @State var recipeIngredients = [IngredientSections]()
    let difficultyOptions = ["easy", "medium", "hard"]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack{
            
            Form {
                SwiftUI.Section{
                    TextField("Recipe Title", text: $title)
                    Picker(selection: $difficultyIndex, label: Text("Recipe Difficulty")) {
                        ForEach(0 ..< difficultyOptions.count, id: \.self) {
                            Text(self.difficultyOptions[$0].capitalized)
                        }
                    }
                    TextField("Cook time (e.g. 1 hour)", text: $cookTime)
                    TextField("Prep time (e.g. 10 minutes)", text: $prepTime)
                    TextField("Image URL", text: $imageURL)
                } header: {
                    Text("Basic Information")
                }
                
                SwiftUI.Section{
                    TextField("Short Description", text: $shortDescription)
                    TextField("Extended Description", text: $shortDescription, axis:.vertical)
                    TextField("Further Information", text: $furtherInfo, axis:.vertical)
                } header: {
                    Text("Description")
                }
                
                SwiftUI.Section{
                    ForEach(tags.indices, id:\.self) { index in
                        TextField("Tag", text: $tags[index].tagName)
                            .swipeActions{
                                Button(role: .destructive) {
                                    tags.remove(at: index)
                                }label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        
                    }
                    Button {
                        tags.append(Tags(tagName: ""))
                    }label: {
                        Text("Add another tag")
                    }
                    
                }header: {
                    Text("Recipe Tags")
                }
                
                FormSteps(simpleStepSections: simpleStepSections)
                
                FormSteps(simpleStepSections: detailedStepSections)
                
                SwiftUI.Section{
                    Button{
                        recipeIngredients.append(IngredientSections(sectionName: "", sectionIngredients: [IngredientsinSection]()))
                    } label: {
                        Text("Add new ingredient section")
                    }
                }header: {
                    Text("Ingredients")
                }
                
                ForEach(recipeIngredients.indices, id: \.self) { index in
                    SwiftUI.Section{
                        TextField("Section Title", text: $recipeIngredients[index].sectionName)
                            .swipeActions{
                                Button(role: .destructive) {
                                    recipeIngredients.remove(at: index)
                                }label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        
                        
                        ForEach(recipeIngredients[index].sectionIngredients.indices, id: \.self){ secondIndex in
                            HStack{
                                TextField("Amount", text: $recipeIngredients[index].sectionIngredients[secondIndex].amount, axis:.vertical)
                                TextField("Units", text: $recipeIngredients[index].sectionIngredients[secondIndex].unit, axis:.vertical)
                                TextField("Ingredient", text: $recipeIngredients[index].sectionIngredients[secondIndex].ingredient, axis:.vertical)
                            }
                            
                                .swipeActions{
                                    Button(role: .destructive) {
                                        recipeIngredients[index].sectionIngredients.remove(at: secondIndex)
                                    }label: {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                            Button {
                                recipeIngredients[index].sectionIngredients.append(IngredientsinSection(amount: "", unit: "", ingredient: ""))
                            }label: {
                                Text("Add another ingredient")
                            }
                            
                        }
                        
                    } header: {
                        Text("Ingredient Section #\(index + 1)")
                    }
                }
                
                
                Button{
                    
                    name = title.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
                    name = name.lowercased()
                    
                    let recipeData = RecipeData(cookTime: cookTime, difficulty: difficultyOptions[difficultyIndex], prepTime: prepTime)
                    
                    let newRecipe = Recipe(description: description, shortDescription: shortDescription, stepsDetailed: detailedStepSections, tags: tags, stepsSimple: simpleStepSections, furtherInfo: furtherInfo, title: title, ingredients: recipeIngredients, imageURL: imageURL, recipeData: recipeData, recipeName: name)
                    
                    dismiss()
                    
                }label:{
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .bold()
                        .foregroundColor(.white)
                }
                .buttonStyle(BorderlessButtonStyle())
                .listRowBackground(Color.blue)
                
                
                
                SwiftUI.Section {
                    Button{
                        title = ""
                        shortDescription = ""
                        description = ""
                        furtherInfo = ""
                        cookTime = ""
                        prepTime = ""
                        difficultyIndex = 0
                    } label: {
                        Text("Reset form")
                    }
                }
            }
            
            .navigationBarTitle("Add a recipe")
            //.navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                        
                    }
                    
                }
            }
            
        }
        .onAppear{
            if tags.count == 0 {
                tags.append(Tags(tagName: ""))
            }
            if detailedStepSections.count == 0 {
                detailedStepSections.append((Sections(sectionName: "", sectionSteps: [Step]())))
            }
            if simpleStepSections.count == 0 {
                simpleStepSections.append((Sections(sectionName: "", sectionSteps: [Step]())))
            }
            if recipeIngredients.count == 0 {
                recipeIngredients.append(IngredientSections(sectionName: "", sectionIngredients: [IngredientsinSection(amount: "", unit: "", ingredient: "")]))
            }
        }
    }
}

struct RecipeForm_Previews: PreviewProvider {
    static var previews: some View {
        RecipeForm()
    }
}
