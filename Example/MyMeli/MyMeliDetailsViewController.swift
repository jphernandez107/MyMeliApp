//
//  MyMeliDetailsViewController.swift
//  MyMeli_Example
//
//  Created by Juan Pablo Hernandez on 19/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class MyMeliDetailsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var freeShippingLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productAttributesTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    private var productId: String?
    private var product: MyMeliProduct?
    
    private var attributeKeysArray: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Details"
        let repository = MyMeliNetworkProductRepository()
        setLoading(true)
        repository.fetchProduct(withId: productId ?? "") {
            self.product = repository.getProduct()
            self.setAttributesKeys()
            self.setUI()
        }
    }
    
    init(productId id: String) {
        super.init(nibName: "MyMeliDetailsViewController", bundle: nil)
        self.productId = id
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUI() {
        DispatchQueue.main.async {
            if let product = self.product {
                self.setLoading(false)
                self.productTitleLabel.text = product.productTitle
                self.productPriceLabel.text = product.getStringPrice()
                self.freeShippingLabel.isHidden = !product.isFreeShiping
                if let imageURL = product.pictureURL {
                    self.productImageView.setImage(from: imageURL)
                }
                self.productAttributesTableView.reloadData()
            } else {
                self.setLoading(true)
            }
        }
    }
    
    private func setLoading(_ isLoading: Bool) {
        self.mainView.isHidden = isLoading
        self.loadingSpinner.isHidden = !isLoading
    }
    
    private func setAttributesKeys() {
        if let attKeys = product?.attributes {
            attributeKeysArray = Array(attKeys.keys)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product?.attributes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MyMeliAttributesTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "myMeliAttributesTableViewCell")
        
        let keyAttribute = attributeKeysArray?[indexPath.row] ?? ""
        let valueAttribute = product?.attributes?[keyAttribute]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMeliAttributesTableViewCell") as! MyMeliAttributesTableViewCell
        cell.keyLabel.text = keyAttribute
        cell.valueLabel.text = valueAttribute
        
        return cell
    }

}
