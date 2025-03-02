//
//  APIManager.swift
//  MVVMPracticePrejoct
//
//  Created by Digitalflake on 23/01/25.
//

import UIKit


//Singleton dessing pattern
enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}


typealias Handler = (Result<[Product], DataError>) -> Void

final class APIManager {
    static let shared = APIManager()
    private init(){}
    
    func  fetchProducts(completion : @escaping Handler){
        guard let url = URL(string: Constatn.API.productURL) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200..<299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
//            JSONDecoder - data ka model  [product array hai ] mai convert karega
            do{
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            }catch{
                completion(.failure(.network(error)))
            }
            
        }.resume()
    }
}
