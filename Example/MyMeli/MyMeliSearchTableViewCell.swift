//
//  MyMeliSearchTableViewCell.swift
//  MyMeli_Example
//
//  Created by Juan Pablo Hernandez on 16/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class MyMeliSearchTableViewCell: UITableViewCell {
    
    @IBOutlet var productTitle: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productFreeShiping: UILabel!
    @IBOutlet var productImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
