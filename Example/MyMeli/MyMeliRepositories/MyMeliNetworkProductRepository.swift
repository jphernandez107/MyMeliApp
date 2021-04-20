//
//  MyMeliNetworkProductRepository.swift
//  MyMeli_Example
//
//  Created by Juan Pablo Hernandez on 19/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import MyMeli

protocol MyMeliNetworkProductRepositoryProtocol {
    func fetchProduct(withId id: String, completion: @escaping () -> Void)
    func getProduct() -> MyMeliProduct?
}

class MyMeliNetworkProductRepository: MyMeliNetworkProductRepositoryProtocol {
    
    var service: MyMeliNetworkProductsServiceProtocol
    var product: MyMeliProduct?
    
    required convenience init() {
        self.init(productListService: MyMeliNetworkProductsService())
    }
    
    required init(productListService: MyMeliNetworkProductsServiceProtocol) {
        service = productListService
    }
    
    func fetchProduct(withId id: String, completion: @escaping () -> Void) {
        service.fetchProduct(withId: id, completion: { data in
            self.product = self.convertProduct(data: data)
            completion()
        }) { error in
            if let error = error {
                print("Error decoding: \(error)")
            } else {
                print("Unknown error")
            }
        }
    }
    
    func getProduct() -> MyMeliProduct? {
        return product
    }
    
    private func convertProduct(data: Data) -> MyMeliProduct? {
        let responseDto = try? JSONDecoder().decode(MyMeliProductResponseDto.self, from: data)
        
        if let productDto = responseDto?.body {
            return convertProduct(productDto)
        }
        return nil
    }
    
    private func convertProduct(_ productDto: MyMeliProductDto) -> MyMeliProduct {
        var product = MyMeliProduct(title: productDto.title ?? "",
                             price: productDto.price ?? 0,
                             isFreeShiping: productDto.shipping?.free_shipping ?? false,
                             thumbnailURL: URL(string: productDto.thumbnail ?? ""),
                             picURL: URL(string: productDto.pictures?[0].secure_url ?? ""))
        
        if let attributes = productDto.attributes {
            var attDict: [String: String] = [:]
            for att in attributes { attDict[att.name!] = att.value_name }
            product.attributes = attDict
        }
        return product
    }
    
}
