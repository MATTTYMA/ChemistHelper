//
//  ShoppingListProductTableViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 29/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import SwipeCellKit

class ShoppingListProductTableViewController: UITableViewController, SwipeTableViewCellDelegate, UpdateParentViewControllerDelegate {
    
    internal var currentRetailer: String?
    private var shoppingList: [ShoppingListItem] = [ShoppingListItem]()
    private let database = DataBase()
    @IBOutlet weak var subtotalLabel: UILabel!
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomShoppingListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "customShoppingListItemCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureTableView()
        enqueryTodoShoppingList(at: currentRetailer ?? "")
    }
    
    //MARK:- tableview Configuration Method
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = .singleLine
    }

    // MARK:- Tableview delegate
    
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    internal override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    // MARK:- Table view data source
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customShoppingListItemCell", for: indexPath) as! CustomShoppingListItemTableViewCell
        cell.delegate = self
        cell.updateDelegate = self
        cell.currentRetailer = self.currentRetailer ?? "Unknown"
        cell.productName.text = shoppingList[indexPath.row].getName()
        cell.priceLabel.text = shoppingList[indexPath.row].getTotalPrice()
        cell.quantityLabel.text = String(shoppingList[indexPath.row].getQuantity())
        if let imageUrl = shoppingList[indexPath.row].getImageURL(){
            cell.productImage.sd_setImage(with: URL(string: imageUrl))
        }
        return cell
    }
    
    //MARK:- swipe tableview delegate method
    internal func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else{return nil}
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if let thisRetailer = self.currentRetailer{
                self.database.deleteShoppingListItem(of: self.shoppingList[indexPath.row].getName(), for: thisRetailer)
                self.enqueryTodoShoppingList(at: thisRetailer)
            }
        }
        return [deleteAction]
    }
    
    //MARK:- Enquery todo shopping list
    private func enqueryTodoShoppingList(at currentRetailer: String) {
        SVProgressHUD.show()
        database.enqueryTodoShoppingList(at: currentRetailer) { (resultList) in
            if let result = resultList{
                self.shoppingList = result
                self.tableView.reloadData()
                self.updateSubtotal()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    //MARK:- update subtotal label
    internal func updateSubtotal(){
        var subtotal = 0.0
        for item in self.shoppingList{
            subtotal += item.getNumericTotallPrice()
        }
        subtotalLabel.text = "$" + String(format:"%.2f", arguments: [subtotal])
    }
    
    internal func updateShoppingList(newList: [ShoppingListItem]) {
        self.shoppingList = newList
        print("protocol excuted")
    }
   
}
