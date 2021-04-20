//
//  MyMeliResponseDto.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 18/04/2021.
//

import Foundation

struct MyMeliProductListResponseDto: Codable {
    var site_id: String?
    var query: String?
    var results: [MyMeliProductDto]?
    
    private enum MyMeliProductListResponseDtoKeys: String, CodingKey {
        case site_id
        case query
        case results
    }
    
    init(from decoder: Decoder) throws {
        if let responseDto = try? decoder.container(keyedBy: MyMeliProductListResponseDtoKeys.self) {
            self.site_id = try responseDto.decode(String.self, forKey: .site_id)
            self.query = try responseDto.decode(String.self, forKey: .query)
            self.results = try responseDto.decode([MyMeliProductDto].self, forKey: .results)
        }
    }
}
