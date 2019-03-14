//
//  Product.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 11/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import Foundation

struct Product {
    
    private var productName : String
    
    private var productImageURL : String
    
    private var productPrice : Int
    
    private var productShoppingURL : String
    
    private var productSource : String
    
    
    mutating func setPrice(at price: Int){
        productPrice = price
    }
    
}
