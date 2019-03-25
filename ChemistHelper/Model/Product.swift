//
//  Product.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 11/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import Foundation

class Product {
    
    private var name : String?
    private var imageURL : String?
    private var price : String?
    private var shoppingURL : String?
    private var categories : [String]?
    private var retailer: String?
    
    init(productName: String, productPrice:String, productImageURL: String, productShoppingURL: String, productCategories:[String], productRetailer: String) {
        self.name = productName
        self.price = productPrice
        self.imageURL = productImageURL
        self.shoppingURL = productShoppingURL
        self.categories = productCategories
        self.retailer = productRetailer
    }
    
    func getName() -> String {
        if let name = self.name{
            return name
        }
        else{
            return "Unknown Name"
        }
    }
    
    func getPrice() -> String{
        if let price = self.price{
            return price
        }else{
            return "Unknow Price"
        }
    }
    
    func getImageURL() -> String? {
        if let imageUrl = self.imageURL{
            return imageUrl
        }else{
            return nil
        }
    }
    
    func getShoppingURL() -> String{
        if let shoppingUrl = self.shoppingURL{
            return shoppingUrl
        }else{
            return "Unknow URL"
        }
    }
    
    func getCategories() -> [String]? {
        if let productCategories = self.categories{
            return productCategories
        }else{
            return nil
        }
    }
    
    func getRetailer() -> String {
        if let productRetailer = self.retailer{
            return productRetailer
        }else{
            return "Unknown Retailer"
        }
    }
    
    func castToDictionary() -> [String:Any] {
        let dict = [
            "product_name": self.getName(),
            "price_at_the_moment": self.getPrice(),
            "retailer": self.getRetailer(),
            "categories": self.getCategories()!,
            "shop_url": self.getShoppingURL(),
            "image_url": self.getImageURL()!,
            ] as [String : Any]
        return dict
    }
    
}
