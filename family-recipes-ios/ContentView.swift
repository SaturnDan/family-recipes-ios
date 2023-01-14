//
//  ContentView.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 15/1/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .favourites
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var modelData: ModelData
    
    enum Tab {
        case list
        case favourites
    }
    
    var body: some View {
        TabView(selection: $selection) {
            FavouritesView()
                .tabItem {
                    Label ("Favourites", systemImage: "star")
                }
                .tag(Tab.favourites)
            ListView()
                .tabItem {
                    Label ("Recipes", systemImage: "list.number")
                }
                .tag(Tab.list)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                modelData.saveData()
            }
            if phase == .active {
                modelData.loadData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
