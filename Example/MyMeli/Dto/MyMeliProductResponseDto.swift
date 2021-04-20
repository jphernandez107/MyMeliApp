//
//  MyMeliProductResponseDto.swift
//  MyMeli_Example
//
//  Created by Juan Pablo Hernandez on 19/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

struct MyMeliProductResponseDto: Codable {
    var code: Int?
    var body: MyMeliProductDto?
    
    private enum MyMeliProductResponseDtoKeys: String, CodingKey {
        case code
        case body
    }
    
    init(from decoder: Decoder) throws {
        if var responseDto = try? decoder.unkeyedContainer() {
            if let productResponseDto = try? responseDto.nestedContainer(keyedBy: MyMeliProductResponseDtoKeys.self) {
                self.code = try productResponseDto.decode(Int.self, forKey: .code)
                self.body = try productResponseDto.decode(MyMeliProductDto.self, forKey: .body)
            }
        }
    }
}
