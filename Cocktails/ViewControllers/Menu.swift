//
//  ViewController.swift
//  Cocktails
//
//  Created by Егор Аблогин on 30.01.2024.
//

import UIKit

final class Menu: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    
    private var isLoadingMoreData = false
    private var menu: [Drink] = []
    private var alphabet = (UnicodeScalar("a").value...UnicodeScalar("z").value)
        .map { String(UnicodeScalar($0)!) }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
      //  fetchCocktailsFrom(letter: "a")
    }
    
    private func fetchIngredients() {
        networkManager.fetch(
            IngredientList.self,
            from: Links.list(filter: .ingredients).url()) { result in
                switch result {
                    case .success(let linkData):
                        linkData.ingredients.forEach{
                            print($0.strIngredient)
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        
        private func fetchCocktailsFrom(letter: String) {
            networkManager.fetch(
                Drinks.self,
                from: Links.search(letter: letter).url()) { result in
                    DispatchQueue.main.async { [unowned self] in
                        switch result {
                            case .success(let drinks):
                                guard let drinksList = drinks.drinks else {
                                    alphabet.remove(at: 0)
                                    isLoadingMoreData = false
                                    return
                                }
                                menu.append(contentsOf: drinksList)
                                tableView.reloadData()
                                activityIndicator.stopAnimating()
                                alphabet.remove(at: 0)
                                if alphabet.isEmpty {
                                    tableView.tableFooterView?.isHidden = true
                                }
                            case .failure(let error):
                                print(error)
                        }
                        isLoadingMoreData = false
                    }
                }
        }
    }
    
// MARK: - UITableViewDataSource
extension Menu: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        guard let menuCell = cell as? MenuCellView else { return UITableViewCell() }
        
        menuCell.cocktailNameLabel.text = menu[indexPath.row].strDrink
        return menuCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        if indexPath.section ==  lastSection && indexPath.row == lastRow && !alphabet.isEmpty {
           // print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(
                x: CGFloat(0),
                y: CGFloat(0),
                width: tableView.bounds.width,
                height: CGFloat(44)
            )

            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
}

// MARK: - UITableViewDelegate
extension Menu: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height
        
        
        if position >= (contentHeight - scrollViewHeight) {
            guard !isLoadingMoreData else { return }
            isLoadingMoreData = true
            
            guard let letter = alphabet.first else { return }
            print(letter, isLoadingMoreData)
            fetchCocktailsFrom(letter: letter)
        }
    }
}

