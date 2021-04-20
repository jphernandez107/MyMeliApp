//
//  MyMeliAttributeDto.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 18/04/2021.
//

import Foundation

struct MyMeliAttributeDto: Codable {
    var id: String?
    var name: String?
    var value_name: String?
    
    private enum MyMeliAttributeDtoKeys: String, CodingKey {
        case id
        case name
        case value_name
    }
    
    init(from decoder: Decoder) throws {
        if let attributeDto = try? decoder.container(keyedBy: MyMeliAttributeDtoKeys.self) {
            self.id = try attributeDto.decode(String.self, forKey: .id)
            self.name = try attributeDto.decode(String.self, forKey: .name)
            self.value_name = try attributeDto.decode(String.self, forKey: .value_name)
        }
    }
}
