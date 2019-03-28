//
//  ShoppingListViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 14/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import SVProgressHUD

class ShoppingListByRetailerViewController: UITableViewController {
    
    private var retailerList:[String]?
    private var productArray: [Product] = [Product]()
    private let database = DataBase()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRetailerList()
    }
    
    //MARK:- Tableview data source method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetailerCell", for: indexPath)
        cell.textLabel?.text = retailerList?[indexPath.row] ?? "You haven't add any product to your list"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retailerList?.count ?? 1
    }
    
    //MARK:- TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Load Retailers in shopping list to retailerList
    private func loadRetailerList(){
        SVProgressHUD.show()
        database.enqueryRetailersInShoppingList { (result) in
            if let resultList = result{
                self.retailerList = resultList
                self.tableView.reloadData()
            }
            SVProgressHUD.dismiss()
        }
        
    }
}

