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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    var cellDrink: Drink? = nil
    
    func setupCell(_ drink: Drink) {
        cellDrink = drink
        cocktailNameLabel.text = drink.strDrink
        let url = URL(string: drink.strDrinkThumb)
        cocktailImage.kf.setImage(with: url)
      
    }
}

extension MenuCellView: Indicator {
    func startAnimatingView() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func stopAnimatingView() {
        activityIndicator.stopAnimating()
    }
    
    var view: Kingfisher.IndicatorView {
        activityIndicator
    }
    
    
}
