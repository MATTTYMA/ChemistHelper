//
//  ShoppingListItem.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 28/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import Foundation

class ShoppingListItem: Product {
    
    private var quantity: Int
    private var done: Bool
    
    init(productName: String, productPrice: String, productImageURL: String, productShoppingURL: String, productCategories: [String], productRetailer: String, numbersOfItem: Int) {
        self.quantity = numbersOfItem
        self.done = false
        super.init(productName: productName, productPrice: productPrice, productImageURL: productImageURL, productShoppingURL: productShoppingURL, productCategories: productCategories, productRetailer: productRetailer)
    }
    
    func getQuantity() -> Int {
        return self.quantity
    }
    
    func haveFinished() -> Bool{
        return self.done
    }
    
}
