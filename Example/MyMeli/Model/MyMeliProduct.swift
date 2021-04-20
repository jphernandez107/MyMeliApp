//
//  MyMeliProduct.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 16/04/2021.
//

import Foundation

public struct MyMeliProduct: Codable {
    
    public var id: String = ""
    public var productTitle: String = ""
    public var productPrice: Double = 0.0
    public var isFreeShiping: Bool = false
    public var thumbnailURL: URL?
    public var pictureURL: URL?
    public var attributes: Dictionary<String, String>?
    
    public init(id: String = "", title: String = "", price: Double = 0,
                isFreeShiping: Bool = false, thumbnailURL: URL?, picURL: URL?){
        self.id = id
        productTitle = title
        productPrice = price
        self.isFreeShiping = isFreeShiping
        self.thumbnailURL = thumbnailURL
        self.pictureURL = picURL
    }
    
    public func getStringPrice() -> String {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "en_US_POSIX")
        nf.numberStyle = .currency
        return nf.string(from: NSNumber(value: productPrice)) ?? "$ 0.00"
    }
    
}
