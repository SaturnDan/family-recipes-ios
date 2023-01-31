//
//  FormSteps.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 1/2/2023.
//

import SwiftUI

struct FormSteps: View {
    @State var simpleStepSections = [Sections]()
    
    var body: some View {
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
    }
}

struct FormSteps_Previews: PreviewProvider {
    static var previews: some View {
        FormSteps()
    }
}
