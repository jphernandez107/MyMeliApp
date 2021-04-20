//
//  MyMeliProductDto.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 18/04/2021.
//

import Foundation

struct MyMeliProductDto: Codable {
    var id: String?
    var title: String?
    var price: Double?
    var thumbnail: String?
    var pictures : [MyMeliProductPictureDto]?
    var shipping: MyMeliShippingDto?
    var attributes: [MyMeliAttributeDto]?
    
    private enum MyMeliProductDtoKeys: String, CodingKey {
        case id
        case title
        case price
        case thumbnail
        case pictures
        case shipping
        case attributes
    }
    
    init (from decoder: Decoder) {
        if let productDto = try? decoder.container(keyedBy: MyMeliProductDtoKeys.self) {
            self.id = try? productDto.decode(String.self, forKey: .id)
            self.title = try? productDto.decode(String.self, forKey: .title)
            self.price = try? productDto.decode(Double.self, forKey: .price)
            self.thumbnail = try? productDto.decode(String.self, forKey: .thumbnail)
            self.pictures = try? productDto.decode([MyMeliProductPictureDto].self, forKey: .pictures)
            self.shipping = try? productDto.decode(MyMeliShippingDto.self, forKey: .shipping)
            self.attributes = try? productDto.decode([MyMeliAttributeDto].self, forKey: .attributes)
        }
    }
}
