//
//  RecipeForm.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 30/1/2023.
//

import SwiftUI

struct RecipeForm: View {
    @State var title: String = ""
    @State var shortDescription: String = ""
    @State var description: String = ""
    @State var furtherInfo: String = ""
    @State var cookTime: String = ""
    @State var prepTime: String = ""
    @State private var difficultyIndex = 0
    @State var tags = [String]()
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
                        ForEach(0 ..< difficultyOptions.count) {
                            Text(self.difficultyOptions[$0].capitalized)
                        }
                    }
                    TextField("Cook time (e.g. 1 hour)", text: $cookTime)
                    TextField("Prep time (e.g. 10 minutes)", text: $prepTime)
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
                    Button{
                        simpleStepSections.append(Sections(sectionName: "", sectionSteps: [Step]()))
                    } label: {
                        Text("Add new section")
                    }
                }header: {
                    Text("Simple Method Steps")
                }
                
                ForEach(simpleStepSections.indices, id: \.self) { index in
                    SwiftUI.Section{
                        TextField("Section Title", text: $simpleStepSections[index].sectionName)
                            .swipeActions{
                                Button(role: .destructive) {
                                    simpleStepSections.remove(at: index)
                                }label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        
                        ForEach(simpleStepSections[index].sectionSteps.indices, id: \.self) { secondIndex in
                            TextField("Step Instruction", text: $simpleStepSections[index].sectionSteps[secondIndex].stepInstruction, axis:.vertical)
                                .swipeActions{
                                    Button(role: .destructive) {
                                        simpleStepSections[index].sectionSteps.remove(at: secondIndex)
                                    }label: {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                        }
                        Button{
                            simpleStepSections[index].sectionSteps.append(Step(stepInstruction: ""))
                        } label: {
                            Text("Add another step")
                        }
                    }header: {
                        Text("Simple Method Section #\(index + 1)")
                    }
                }
                
                SwiftUI.Section{
                    Button{
                        detailedStepSections.append(Sections(sectionName: "", sectionSteps: [Step]()))
                    } label: {
                        Text("Add new section")
                    }
                }header: {
                    Text("Detailed Method Steps")
                }
                
                ForEach(detailedStepSections.indices, id: \.self) { index in
                    SwiftUI.Section{
                        TextField("Section Title", text: $detailedStepSections[index].sectionName)
                            .swipeActions{
                                Button(role: .destructive) {
                                    detailedStepSections.remove(at: index)
                                }label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        
                        ForEach(detailedStepSections[index].sectionSteps.indices, id: \.self) { secondIndex in
                            TextField("Step Instruction", text: $detailedStepSections[index].sectionSteps[secondIndex].stepInstruction, axis:.vertical)
                                .swipeActions{
                                    Button(role: .destructive) {
                                        detailedStepSections[index].sectionSteps.remove(at: secondIndex)
                                    }label: {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                        }
                        Button{
                            detailedStepSections[index].sectionSteps.append(Step(stepInstruction: ""))
                        } label: {
                            Text("Add another step")
                        }
                    }header: {
                        Text("Detailed Method Section #\(index + 1)")
                    }
                }
                
                SwiftUI.Section{
                    Button{
                        recipeIngredients.append(IngredientSections(sectionName: "", sectionIngredients: [IngredientsinSection]()))
                    } label: {
                        Text("Add new ingredient section")
                    }
                }header: {
                    Text("Ingredients")
                }
                /*
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
                 
                 ForEach(recipeIngredients[index].sectionIngredients.indices, id: \.self) { secondIndex in
                 
                 HStack{
                 TextField("Step Instruction", text: $recipeIngredients[index].sectionIngredients[secondIndex].amount, axis:.vertical)
                 TextField("Step Instruction", text: $recipeIngredients[index].sectionIngredients[secondIndex].instruction, axis:.vertical)
                 TextField("Step Instruction", text: $recipeIngredients[index].sectionIngredients[secondIndex].unit, axis:.vertical)
                 }
                 .swipeActions{
                 Button(role: .destructive) {
                 $recipeIngredients[index].sectionIngredients.remove(at: secondIndex)
                 }label: {
                 Image(systemName: "minus.circle")
                 .foregroundColor(.red)
                 }
                 }
                 }
                 
                 Button{
                 recipeIngredients[index].sectionIngredients.append(IngredientsinSection(amount: "", instruction: "", unit: ""))
                 } label: {
                 Text("Add another step")
                 }
                 }
                 
                 }
                 */
                
                Button{
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
        
    }
}

struct RecipeForm_Previews: PreviewProvider {
    static var previews: some View {
        RecipeForm()
    }
}
