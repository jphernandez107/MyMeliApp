//
//  MyMeliProductPictureDto.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 18/04/2021.
//

import Foundation

struct MyMeliProductPictureDto: Codable {
    var id: String?
    var url: String?
    var secure_url: String?
    
    private enum MyMeliPictureDtoKeys: String, CodingKey {
        case id
        case url
        case secure_url
    }
    
    init(from decoder: Decoder) throws {
        if let pictureDto = try? decoder.container(keyedBy: MyMeliPictureDtoKeys.self) {
            self.id = try pictureDto.decode(String.self, forKey: .id)
            self.url = try pictureDto.decode(String.self, forKey: .url)
            self.secure_url = try pictureDto.decode(String.self, forKey: .secure_url)
//            self.size = try attributeDto.decode(String.self, forKey: .size)
//            self.maxSize = try attributeDto.decode(String.self, forKey: .maxSize)
//            self.quality = try attributeDto.decode(String.self, forKey: .quality)
        }
    }
}
