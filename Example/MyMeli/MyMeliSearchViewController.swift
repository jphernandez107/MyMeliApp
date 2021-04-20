//
//  MyMeliSearchViewController.swift
//  MyMeli_Example
//
//  Created by Juan Pablo Hernandez on 16/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import MyMeli

class MyMeliSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyListLabel: UILabel!
    @IBOutlet var loadingSpinner: UIActivityIndicatorView!
    
    var products = [MyMeliProduct]()
    var myMeliRepository = MyMeliNetworkProductListRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Búscate un producto en MeLi wey!"
        searchController.searchBar.delegate = self
        
        if #available(iOS 13.0, *) {
            let searchBarAppearence = UINavigationBarAppearance()
        } else {
            // Fallback on earlier versions
        }
        
        
        searchController.searchBar.barTintColor = UIColor(red: 255/255, green: 241/255, blue: 89/255, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 241/255, blue: 89/255, alpha: 1)
        self.navigationItem.searchController = searchController
        setLoading(false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.setLoading(true)
        myMeliRepository.searchProducts(searchText: searchBar.text ?? "") {
            self.products = self.myMeliRepository.getProductList()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.checkEmptyList()
                self.setLoading(false)
                self.navigationItem.searchController?.isActive = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MyMeliSearchTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "myMeliSearchTableViewCell")
        
        let item: MyMeliProduct = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMeliSearchTableViewCell") as! MyMeliSearchTableViewCell
        cell.productTitle.text = item.productTitle
        cell.productPrice.text = item.getStringPrice()
        cell.productFreeShiping.isHidden = !item.isFreeShiping
        if let thumbURL = item.thumbnailURL { cell.productImage.setImage(from: thumbURL) }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productId = products[indexPath.row].id
        let detailsController = MyMeliDetailsViewController(productId: productId)
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
    
    private func checkEmptyList() {
        if products.isEmpty {
            self.tableView.isHidden = true
            self.emptyListLabel.isHidden = false
            self.emptyListLabel.text = "No se encontraron resultados. Intentá nuevamente"
        } else {
            self.tableView.isHidden = false
            self.emptyListLabel.isHidden = true
        }
    }
    
    private func setLoading(_ isLoading: Bool) {
        self.tableView.isHidden = isLoading || self.tableView.isHidden
        self.emptyListLabel.isHidden = isLoading || self.emptyListLabel.isHidden
        self.loadingSpinner.isHidden = !isLoading
    }

}
