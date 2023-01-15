//
//  RecipeRow.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 16/1/2023.
//

import SwiftUI

struct RecipeRow: View {
    @EnvironmentObject var modelData: ModelData
    @State var emotes: Emotes
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow()
    }
}
