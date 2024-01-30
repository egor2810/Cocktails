//
//  Drinks.swift
//  Cocktails
//
//  Created by Егор Аблогин on 30.01.2024.
//

struct Drink: Decodable {
    enum DrinkCategory: String, Decodable {
        case OrdinaryDrink = "Ordinary Drink"
        case Cocktail
        case Shake
        case Other = "Other / Unknown"
        case Cocoa
        case Shot
        case Coffee = "Coffee / Tea"
        case Homemade = "Homemade Liqueur"
        case Punch = "Punch / Party Drink"
        case Beer
        case Soft = "Soft Drink"
    }
    
    let idDrink: String
    let strDrink: String

    let strCategory: DrinkCategory
    
    let strAlcoholic: String
    let strGlass: String
    let strInstructions: String
    let strInstructionsES: String?
    let strInstructionsDE: String?
    let strInstructionsFR: String?
    let strInstructionsIT: String?
    let strInstructionsZH: String?

    let strDrinkThumb: String
    let strIngredient1: String
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
}

struct Drinks: Decodable {
    let drinks: [Drink]
}

struct Ingredient: Decodable {
    enum CodingKeys: String, CodingKey {
        case strIngredient = "strIngredient1"
    }
    
    let strIngredient: String
}

struct IngredientList: Decodable {
    enum CodingKeys: String, CodingKey {
        case ingredients = "drinks"
    }
    
    let ingredients: [Ingredient]
}
