// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - Welcome
struct TransformerRecipe: Codable, Equatable {
    var count: Int
    var items: [Item]
    var scannedCount: Int

    enum CodingKeys: String, CodingKey {
        case count = "Count"
        case items = "Items"
        case scannedCount = "S"
    }
}

// MARK: - Item
struct Item: Codable, Equatable {
    var recipeName: StringHolder
    var stepsDetailed: Steps
    var shortDescription, image: StringHolder
    var data: DataClass
    var stepsSimple: Steps
    var description: Description
    var ingredients: Ingredients
    var tags: Description
    var title: StringHolder
    var furtherInfo: Description
}

// MARK: - DataClass
struct DataClass: Codable, Equatable {
    var m: DataM

    enum CodingKeys: String, CodingKey {
        case m = "M"
    }
}

// MARK: - DataM
struct DataM: Codable, Equatable {
    var cookTime, difficulty, prepTime: StringHolder
}

// MARK: - StringHolder
struct StringHolder: Codable, Equatable {
    var s: String

    enum CodingKeys: String, CodingKey {
        case s = "S"
    }
}

// MARK: - Description
struct Description: Codable, Equatable {
    var l: [StringHolder]

    enum CodingKeys: String, CodingKey {
        case l = "L"
    }
}

// MARK: - Ingredients
struct Ingredients: Codable, Equatable {
    var l: [IngredientsL]

    enum CodingKeys: String, CodingKey {
        case l = "L"
    }
}

// MARK: - IngredientsL
struct IngredientsL: Codable, Equatable {
    var m: PurpleM

    enum CodingKeys: String, CodingKey {
        case m = "M"
    }
}

// MARK: - PurpleM
struct PurpleM: Codable, Equatable {
    var sectionName: StringHolder
    var sectionIngredients: SectionIngredients
}

// MARK: - SectionIngredients
struct SectionIngredients: Codable, Equatable {
    var l: [SectionIngredientsL]

    enum CodingKeys: String, CodingKey {
        case l = "L"
    }
}

// MARK: - SectionIngredientsL
struct SectionIngredientsL: Codable, Equatable {
    var m: Ingredient

    enum CodingKeys: String, CodingKey {
        case m = "M"
    }
}

// MARK: - FluffyM
struct Ingredient: Codable, Equatable {
    var amount, unit, ingredient: StringHolder
}

// MARK: - Steps
struct Steps: Codable, Equatable {
    var l: [StepsDetailedL]

    enum CodingKeys: String, CodingKey {
        case l = "L"
    }
}

// MARK: - StepsDetailedL
struct StepsDetailedL: Codable, Equatable {
    var m: Section

    enum CodingKeys: String, CodingKey {
        case m = "M"
    }
}

// MARK: - SectionName
struct Section: Codable, Equatable {
    var sectionName: StringHolder
    var sectionSteps: Description
}
