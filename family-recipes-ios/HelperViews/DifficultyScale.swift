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
                Image(uiImage: UIImage(systemName: "thermometer.low")!)
            case "medium":
                Image(uiImage: UIImage(systemName: "thermometer.medium")!)
            case "hard":
                Image(uiImage: UIImage(systemName: "thermometer.high")!)
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
