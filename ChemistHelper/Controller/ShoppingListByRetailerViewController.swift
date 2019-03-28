//
//  ShoppingListViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 14/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit

class ShoppingListByRetailerViewController: UITableViewController {
    
    private var retailerList:[String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shoppinglist"
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

}

