//
//  MyMeliNetworkProductListRepository.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 16/04/2021.
//

import Foundation
import MyMeli

protocol MyMeliNetworkProductListRepositoryProtocol {
    func searchProducts(searchText text: String, completion: @escaping () -> Void)
    func getProductList() -> [MyMeliProduct]
}

class MyMeliNetworkProductListRepository: MyMeliNetworkProductListRepositoryProtocol {
    
    var service: MyMeliNetworkProductsServiceProtocol
    var products = [MyMeliProduct]()
    
    required convenience init() {
        self.init(productListService: MyMeliNetworkProductsService())
    }
    
    required init(productListService: MyMeliNetworkProductsServiceProtocol) {
        service = productListService
    }
    
    func searchProducts(searchText text: String, completion: @escaping () -> Void) {
        service.searchProducts(searchText: text, completion: { data in
            self.products = self.convertProducts(data: data)
            completion()
        }) { error in
            if let error = error {
                print("Error decoding: \(error)")
            } else {
                print("Unknown error")
            }
        }
    }
    
    func getProductList() -> [MyMeliProduct] {
        return products
    }
    
    private func convertProducts(data: Data) -> [MyMeliProduct] {
        let responseDto = try? JSONDecoder().decode(MyMeliProductListResponseDto.self, from: data)
        
        var products = [MyMeliProduct]()
        if let results = responseDto?.results {
            for productDto in results {
                products.append(convertProduct(productDto))
            }
            return products
        }
        return [MyMeliProduct]()
    }
    
    private func convertProduct(_ productDto: MyMeliProductDto) -> MyMeliProduct {
        return MyMeliProduct(id: productDto.id ?? "",
                             title: productDto.title ?? "",
                             price: productDto.price ?? 0,
                             isFreeShiping: productDto.shipping?.free_shipping ?? false,
                             thumbnailURL: URL(string: productDto.thumbnail ?? ""),
                             picURL: nil)
    }
    
}
