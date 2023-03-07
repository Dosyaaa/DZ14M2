//
//  NetworkLayer.swift
//  DZ14M
//
//  Created by User on 23/2/23.
//

import Foundation

enum HTTPRequest: String {
    case GET,POST,PUT,DELETE
}

final class NetworkLayer {
    static let shared = NetworkLayer()
    
    private init() { }
    
    private var baseURL = URL(string: "https://dummyjson.com/products")!
    
    func fetchProducts() throws -> [Products] {
        let decoder = JSONDecoder()
        let products = try decoder.decode([Products].self, from: Data(productsJSON.utf8))
        return products
    }
    
    func fetchOrders() throws -> [Order] {
        let decoder = JSONDecoder()
        let orders = try decoder.decode([Order].self, from: Data(orderJSON.utf8))
        return orders
    }
    
    func searchFetchProducts(
        completion: @escaping (Result<[ProductsName],
                               Error>
        ) -> Void) {
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                let model: ProductsSearch = self.decode(with: data)
                completion(.success(model.products))
            }
        }
        .resume()
    }
    
    func searchFetchProducts() async throws -> [ProductsName] {
        let request = URLRequest(url: baseURL)
        let (data, response) = try await URLSession.shared.data(for: request)
        let model: ProductsSearch = self.decode(with: data)
        return model.products
    }
    
    func searchProducts(
        by word: String,
        completion: @escaping (Result<[ProductsName],
                               Error>
        ) -> Void) {
        let url = baseURL.appendingPathComponent("search")
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [.init(name: "q", value: word)]
        if let url = urlComponents?.url {
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    let model: ProductsSearch = self.decode(with: data)
                    completion(.success(model.products))
                }
            }
            .resume()
        }
    }
    
    func searchProducts() async throws -> [ProductsName] {
        let url = baseURL.appendingPathComponent("search")
        let (data, response) = URLSession.shared.data(for: url)
    }
    
    public func changeProduct(
        with model: ProductsName,
        completion: @escaping (
            Result<Bool,
            Error>
        ) -> Void) {
        _ = baseURL.appendingPathComponent("add")
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPRequest.PUT.rawValue
        request.httpBody = encode(with: model)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if  data != nil {
                completion(.success(true))
            }
        }
        .resume()
    }
    
    public func deleteProduct(
        with model: ProductsName,
        completion: @escaping (Result<Bool, Error>
        ) -> Void) {
        baseURL.removeAllCachedResourceValues()
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPRequest.DELETE.rawValue
        request.httpBody = encode(with: model)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if data != nil {
                completion(.success(true))
            }
        }
        .resume()
    }
    
    func decode<T: Decodable>(with data: Data) -> T {
        try! JSONDecoder().decode(T.self, from: data)
    }
    func encode<T: Encodable>(with model: T) -> Data {
        try! JSONEncoder().encode(model)
    }
}

