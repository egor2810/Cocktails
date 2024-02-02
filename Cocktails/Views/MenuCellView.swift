//
//  MenuCellView.swift
//  Cocktails
//
//  Created by Егор Аблогин on 01.02.2024.
//

import UIKit
import Kingfisher

final class MenuCellView: UITableViewCell {
    
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailType: UILabel!
    @IBOutlet weak var cocktailAlcoholic: UILabel!
    
    
    var cellDrink: Drink? = nil
    
    func setupCell(_ drink: Drink) {
        cellDrink = drink
        cocktailImage.layer.cornerRadius = 20
        cocktailNameLabel.text = drink.strDrink
        cocktailType.text = drink.strCategory.rawValue
        cocktailAlcoholic.text = drink.strAlcoholic
        let url = URL(string: drink.strDrinkThumb)
     
        // TODO: Добавить дефолтное изображение
        cocktailImage.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .transition(.fade(1)),
                // TODO: Кэширование оригинального изображения(пока рано)
                //.cacheOriginalImage
            ])
    }
}
