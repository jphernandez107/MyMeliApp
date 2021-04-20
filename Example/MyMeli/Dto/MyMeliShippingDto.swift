//
//  MyMeliShippingDto.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 18/04/2021.
//

import Foundation

struct MyMeliShippingDto: Codable {
//    var logistic_type: String?
//    var mode: String?
    var free_shipping: Bool?
    
    private enum MyMeliShippingDtoKeys: String, CodingKey {
//        case logistic_type
//        case mode
        case free_shipping
    }
    
    init (from decoder: Decoder) throws {
        if let shippingDto = try? decoder.container(keyedBy: MyMeliShippingDtoKeys.self) {
            self.free_shipping = try shippingDto.decode(Bool.self, forKey: .free_shipping)
        }
    }
}
