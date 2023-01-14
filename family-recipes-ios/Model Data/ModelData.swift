//
//  ModelData.swift
//  family-recipes-ios
//
//  Created by Dan Malyaris on 15/1/2023.
//

import Foundation
import Combine
import UIKit
import SwiftUI

final class ModelData: ObservableObject {
    let saveKey = "SaveData"
    
    func saveData() {
        
    }
    
    func loadData(){
        clearDefaults()
    }
    
    func clearDefaults(){
        UserDefaults.standard.removeObject(forKey: saveKey)
        UserDefaults.standard.synchronize()
    }
}
