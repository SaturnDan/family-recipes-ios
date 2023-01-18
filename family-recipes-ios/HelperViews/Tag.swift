//
//  Tag.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 17/1/2023.
//

import SwiftUI

struct Tag: View {
    var title: String
    var backgroundColour: Color = Color(UIColor.systemGray6)
    var textColor: Color?
    
    var body: some View {
        Text(title)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .foregroundColor(textColor ?? .black)
            .background(backgroundColour)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(backgroundColour.darker(by: 50), lineWidth: 2)
            )
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag(title: "Pizza", backgroundColour: Color(.cyan))
    }
}
