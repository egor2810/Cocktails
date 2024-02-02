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
    
    var cellDrink: Drink? = nil
    
    func setupCell(_ drink: Drink) {
        cellDrink = drink
        cocktailNameLabel.text = drink.strDrink
        let url = URL(string: drink.strDrinkThumb)
     
        // TODO: Добавить дефолтное изображение
        cocktailImage.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .transition(.fade(2)),
                // TODO: Кэширование оригинального изображения(пока рано)
                //.cacheOriginalImage
            ]) {
            result in
            switch result {
            case .success(let value):
                print("Изображение загружено: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Ошибка загрузки: \(error.localizedDescription)")
            }
        }
      
    }
}
