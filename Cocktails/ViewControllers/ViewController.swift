//
//  ViewController.swift
//  Cocktails
//
//  Created by Егор Аблогин on 30.01.2024.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchIngredients()
        fetchCocktailsFrom(letter: "a")
    }
    
    private func fetchIngredients() {
        URLSession.shared.dataTask(
            with: URL(string: Links.allIngredients.rawValue)!
        ) { data, response, error in
            guard let data, let response else {
                print(error?.localizedDescription ?? "No Error!")
                return
            }
            print(response)
            do {
                let linkData = try JSONDecoder().decode(IngredientList.self, from: data)
                linkData.ingredients.forEach{
                    print($0.strIngredient)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    private func fetchCocktailsFrom(letter: String) {
        URLSession.shared.dataTask(
            with: URL(string: Links.allCocktailsFromLetter.rawValue + letter)!
        ) { data, response, error in
            guard let data, let response else {
                print(error?.localizedDescription ?? "No Error!")
                return
            }
            print(response)
            do {
                let linkData = try JSONDecoder().decode(Drinks.self, from: data)
                linkData.drinks.forEach{ drink in
                    let cocktailsString =
                        """
                        Name: \(drink.strDrink)
                        Category: \(drink.strCategory.rawValue)
                        Instruction: \(drink.strInstructions)
                        """
                    
                    print()
                    print(cocktailsString)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

