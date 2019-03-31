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
    
    init(productName: String, productPrice: String, productImageURL: String, productShoppingURL: String, productCategories: [String], productRetailer: String, numbersOfItem: Int, done: Bool) {
        self.quantity = numbersOfItem
        self.done = done
        super.init(productName: productName, productPrice: productPrice, productImageURL: productImageURL, productShoppingURL: productShoppingURL, productCategories: productCategories, productRetailer: productRetailer)
    }
    
    internal func getQuantity() -> Int {
        return self.quantity
    }
    
    internal func haveFinished() -> Bool{
        return self.done
    }
    
    internal func getTotalPrice() -> String {
        let singlePrice = getNumericPrice(self.getPrice())
        return "$"+String(singlePrice*Double(self.quantity))
    }
    
    private func getNumericPrice(_ stringValue: String)->Double{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return Double(truncating: formatter.number(from: stringValue)!)
    }
}
