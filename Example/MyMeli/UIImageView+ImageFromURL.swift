//
//  UIImageView+ImageFromURL.swift
//  MyMeli_Example
//
//  Created by Juan Pablo Hernandez on 18/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
}
