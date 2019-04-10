//
//  UpdateParentDelegate.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 10/4/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import Foundation

protocol UpdateParentViewControllerDelegate {
    
    func updateShoppingList(newList: [ShoppingListItem])
    
    func updateSubtotal()
    
}
