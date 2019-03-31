//
//  ProductEnqueryViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 14/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import SwipeCellKit
import SDWebImage
import SVProgressHUD

class ProductEnqueryViewController: UITableViewController, UISearchBarDelegate, SwipeTableViewCellDelegate {
   
    private let database = DataBase()
    private var productArray: [Product] = [Product]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomProductCell", bundle: nil), forCellReuseIdentifier: "customProductCell")
        configureTableView()
        searchBar.delegate = self
        self.title = "Product Search"
    }
    
   
    //MARK:- Searching Bar Method
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SVProgressHUD.show()
        database.searchProduct(searchBar.text!) { (result) in
            if let resultObtained = result{
                self.productArray = resultObtained
                self.tableView.reloadData()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    
    
    //MARK:- tableview Configuration Method
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150.0
        tableView.separatorStyle = .singleLine
    }
    
    //MARK:- Tableview delegate methods
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    internal override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    //MARK:- Tableview DataSource Methods
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customProductCell", for: indexPath) as! CustomProductCell
        cell.delegate = self
        cell.productName.text = productArray[indexPath.row].getName()
        cell.productPrice.text = productArray[indexPath.row].getPrice()
        cell.productRetailer.text = productArray[indexPath.row].getRetailer()
        if let imageUrl = productArray[indexPath.row].getImageURL(){
            cell.productImage.sd_setImage(with: URL(string: imageUrl))
        }
        return cell
    }
    
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    
    //MARK:- SwipeTableViewCell delegate methods
    internal func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let visitShopURL = SwipeAction(style: .destructive, title: "Visit Shop") { (action, indexPath) in
            //TODO: visit shop function
        }
        let addToShoppingList = SwipeAction(style: .destructive, title: "addToShoppingList") { (action, indexPath) in
            self.addToShoppingListPressed(on: indexPath)
            tableView.reloadData()
        }
        return [visitShopURL, addToShoppingList]
    }
    
    //MARK:- add to shopping list methods
    
    internal func addToShoppingListPressed(on indexPath: IndexPath) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Quantity", message: "Enter the quantity you need to buy", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add To Shopping List", style: .default) { (action) in
            //TODO: add to firebase users/shoppinglist
            if let quantity = textField.text{
                self.database.addToShoppingList(prodcut: self.productArray[indexPath.row], quantity: Int(quantity) ?? 1)
            }
        }
        let dismissAction = UIAlertAction(title:"Dismiss", style: .destructive, handler: nil)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Product of Quantity"
            textField = alertTextField
        }
        alert.addAction(addAction)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }

}
