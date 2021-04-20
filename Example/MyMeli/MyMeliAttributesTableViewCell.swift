//
//  MyMeliAttributesTableViewCell.swift
//  MyMeli_Example
//
//  Created by Juan Pablo Hernandez on 19/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class MyMeliAttributesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
