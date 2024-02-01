//
//  Links.swift
//  Cocktails
//
//  Created by Егор Аблогин on 30.01.2024.
//

import Foundation

enum Links {
    // MARK: - List the categories, glasses, ingredients or alcoholic filters
    enum Filters: String {
        case categories = "c"
        case glasses = "g"
        case ingredients = "i"
        case alcoholic = "a"
    }
    
    // MARK: - Cases
    case search(letter: String)
    case list(filter: Filters)
    
    // MARK: - Base URL for API
    var baseUrl: String {
        "https://www.thecocktaildb.com/api/json/v1/1/"
    }
    
    // MARK: - URL modification for API methods
    func url() -> URL {
        switch self {
            case .search(let letter):
                URL(string: "\(baseUrl)search.php?f=\(letter)")!
            case .list(let filter):
                URL(string: "\(baseUrl)list.php?\(filter.rawValue)=list")!
        }
        
    }
    
}
