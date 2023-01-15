//
//  FavouriteButton.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 16/1/2023.
//

import SwiftUI

struct FavouriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        HStack{
            Button {
                isSet.toggle()
            } label: {
                Image(systemName: "star")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}

struct FavouriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteButton(isSet: .constant(true))
    }
}
