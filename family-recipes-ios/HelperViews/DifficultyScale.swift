//
//  DifficultyScale.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 18/1/2023.
//

import SwiftUI

struct DifficultyScale: View {
    var difficulty: String
    
    var body: some View {
        HStack{
            switch difficulty {
            case "easy":
                HStack (alignment: .center){
                    Image(uiImage: UIImage(systemName: "thermometer.low")!)
                    Text("EASY")
                        .font(Font.custom("Comfortaa", size: 15))
                }
            case "medium":
                HStack(alignment: .center){
                    Image(uiImage: UIImage(systemName: "thermometer.low")!)
                    Text("MEDIUM")
                        .font(Font.custom("Comfortaa", size: 15))
                }
            case "hard":
                HStack(alignment: .center){
                    Image(uiImage: UIImage(systemName: "thermometer.low")!)
                    Text("HARD")
                        .font(Font.custom("Comfortaa", size: 15))
                }
            default:
                Image(uiImage: UIImage(systemName: "exclamationmark.triangle")!)
                
            }
        }
    }
}

struct DifficultyScale_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DifficultyScale(difficulty: "easy")
            DifficultyScale(difficulty: "medium")
            DifficultyScale(difficulty: "hard")
        }
        
    }
}
