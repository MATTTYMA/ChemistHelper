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
    private let database = DataBase()

    internal override func viewDidLoad() {
        super.viewDidLoad()
        loadRetailerList()
    }
    
    //MARK:- Tableview data source method
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetailerCell", for: indexPath)
        cell.textLabel?.text = retailerList?[indexPath.row] ?? "You haven't add any product to your list"
        return cell
    }
    
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retailerList?.count ?? 1
    }
    
    //MARK:- TableView delegate methods
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = self.retailerList{
            self.performSegue(withIdentifier: "goToProducts", sender: self)
        }
    }
    
    internal override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
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
    
    //MARK:- Segue Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShoppingListProductTableViewController{
            if let retailers = self.retailerList{
                destination.currentRetailer = retailers[self.tableView.indexPathForSelectedRow!.row]
                tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
    
}

