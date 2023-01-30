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
            Toggle("Save recipe as a favourite?", isOn: $isSet)
                .font(.subheadline)
        }
    }
}

struct FavouriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteButton(isSet: .constant(true))
    }
}
