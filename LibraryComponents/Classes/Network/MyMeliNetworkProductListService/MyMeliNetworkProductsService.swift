//
//  MyMeliNetworkProductsService.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 16/04/2021.
//

import Foundation

public protocol MyMeliNetworkProductsServiceProtocol {
    func searchProducts(searchText text: String,
                        completion: @escaping (Data) -> Void,
                        onFailure: @escaping (Error?) -> Void)
    func fetchProduct(withId id: String,
                      completion: @escaping (Data) -> Void,
                      onFailure: @escaping (Error?) -> Void)
}

public class MyMeliNetworkProductsService: MyMeliNetworkProductsServiceProtocol {
    
    let baseURL = "https://api.mercadolibre.com"
    private var urlSession: URLSession
    
    public init() {
        urlSession = URLSession.shared
    }
    
    public func searchProducts(searchText text: String,
                        completion: @escaping (Data) -> Void,
                        onFailure: @escaping (Error?) -> Void) {
        
        let queryString = "/sites/MLA/search?q="
        let url = URL(string: baseURL + queryString + (text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""))
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { data, response, error in // Data?, URLResponse?, Error?
            if let error = error {
                onFailure(error)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(data)
                } else {
                    onFailure(URLError(.unknown))
                }
            } else {
                return onFailure(nil)
            }
        }.resume()
    }
    
    public func fetchProduct(withId id: String,
                             completion: @escaping (Data) -> Void,
                             onFailure: @escaping (Error?) -> Void) {
        let queryString = "/items?ids=\(id)"
        let stringURL = baseURL + queryString
        let url = URL(string: stringURL)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                onFailure(error)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(data)
                } else {
                    onFailure(URLError(.unknown))
                }
            } else {
                return onFailure(nil)
            }
        }.resume()
    }
}

