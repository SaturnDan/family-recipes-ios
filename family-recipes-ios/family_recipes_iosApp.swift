//
//  family_recipes_iosApp.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 15/1/2023.
//

import SwiftUI

@main
struct family_recipes_iosApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData())
        }
    }
}
