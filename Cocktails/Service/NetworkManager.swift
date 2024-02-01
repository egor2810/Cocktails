//
//  NetworkManager.swift
//  Cocktails
//
//  Created by Егор Аблогин on 01.02.2024.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
}

enum httpMethods: String {
    case fetch = "GET"
    case post = "POST"
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, let response else {
                print(error ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let dataModel = try decoder.decode(T.self, from: data)
                
                completion(.success(dataModel))
                
            } catch {
                print(data, response , error)
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
}


