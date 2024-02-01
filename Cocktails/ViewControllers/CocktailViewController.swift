//
//  CocktailViewController.swift
//  Cocktails
//
//  Created by Егор Аблогин on 02.02.2024.
//

import UIKit

final class CocktailViewController: UIViewController {

    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var cocktailName: UILabel!
    @IBOutlet weak var cocktailMakingInfo: UILabel!
    
    var drink: Drink!
    var drinkImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailImage.image = drinkImage
        cocktailName.text = drink.strDrink
        cocktailMakingInfo.text = drink.strInstructions
    }

}
