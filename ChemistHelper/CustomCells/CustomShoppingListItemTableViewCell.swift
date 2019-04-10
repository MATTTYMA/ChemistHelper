//
//  CustomShoppingListItemTableViewCell.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 29/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import SwipeCellKit
import SVProgressHUD

protocol UpdateParentViewControllerDelegate {
    
    func updateShoppingList(newList: [ShoppingListItem])
    func updateSubtotal()
}

class CustomShoppingListItemTableViewCell: SwipeTableViewCell, UITextFieldDelegate {
    
    private let dataBase = DataBase()
    
    internal var currentRetailer: String = ""

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UITextField!
    
    var updateDelegate: UpdateParentViewControllerDelegate?
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if let oldValue = Int(quantityLabel.text!){
            let newQuantity: Int = oldValue+1
            quantityLabel.text = String(newQuantity)
            updateQuantity(with: newQuantity)
        }
    }
    
    @IBAction func subButtonPressed(_ sender: UIButton) {
        if let oldValue = Int(quantityLabel.text!){
            let newQuantity: Int = oldValue-1
            quantityLabel.text = String(newQuantity)
            updateQuantity(with: newQuantity)
        }
    }
    
    internal override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        quantityLabel.delegate = self
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        updateQuantity(with: Int(textField.text ?? "0") ?? 0)
    }

    internal override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateQuantity(with number: Int){
        SVProgressHUD.show()
        dataBase.updateShoppingListItemQuantity(of: productName.text!, with: number, at: currentRetailer) { (newTotalPrice) in
            if let newSubtotal = newTotalPrice{
                self.priceLabel.text = "$" + String(format:"%.2f", arguments:[newSubtotal])
                self.dataBase.enqueryTodoShoppingList(at: self.currentRetailer, completion: { (newList) in
                    if let listToBeUpdated = newList{
                        self.updateDelegate?.updateShoppingList(newList: listToBeUpdated)
                        self.updateDelegate?.updateSubtotal()
                    }
                })
            }
            SVProgressHUD.dismiss()
        }
    }
    
}
