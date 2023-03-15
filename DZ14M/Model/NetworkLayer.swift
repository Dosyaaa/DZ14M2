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

    func searchFetchProducts() async throws -> [ProductsName] {
        let request = URLRequest(url: baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        let model: ProductsSearch = self.decode(with: data)
        return model.products
    }
    
    func searchProduct(by word: String) async throws -> [Products] {
        let url = baseURL.appendingPathComponent("search")
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [.init(name: "q", value: word)]
        guard let url = urlComponents?.url else {
            return try [Products](from: [] as! Decoder)
        }
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return try! decode(with: data)
    }
    
    func changeProduct(with model: ProductsName) async throws -> Bool {
        var encodedProduct: Data?
        encodedProduct = decode(with: encodedProduct!)
        guard encodedProduct != nil else { return false }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPRequest.POST.rawValue
        request.httpBody = encodedProduct
        let (_, response) = try await URLSession.shared.data(for: request)
        if response is HTTPURLResponse { return true
        } else {
            return false
        }
    }

    func deleteProduct() async throws -> Bool {
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPRequest.DELETE.rawValue
        let (_, response) = try await URLSession.shared.data(for: request)
        if
            response is HTTPURLResponse { return true
        } else {
            return false
        }
    }
    
    func decode<T: Decodable>(with data: Data) -> T {
        try! JSONDecoder().decode(T.self, from: data)
    }
    func encode<T: Encodable>(with model: T) -> Data {
        try! JSONEncoder().encode(model)
    }
}

