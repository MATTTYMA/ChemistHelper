//
//  DataBase.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 15/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import SVProgressHUD

class DataBase{
    
    private let dataBase = Firestore.firestore()
    
    //MARK:- WelcomViewController
    //MARK:- Check log in statue method
    
    func hasLogin() -> Bool {
        if Auth.auth().currentUser != nil{
            print(Auth.auth().currentUser?.email! ?? "Unknown")
            return true
        } else {
            print("no user logged in")
            return false
        }
    }
    
    // MARK:- LogInViewController
    // MARK:- Sign On methods
    
    func signOn(_ userEmail: String, _ userPassword: String, _ userNickname: String, completion: @escaping (String?)->())  {
        self.userNameExists(userNickname) { (error) in
            if let userNameExistError = error{
                completion(userNameExistError)
            }else{
                Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (user, error) in
                    if let errorCaptured = error {
                        completion(errorCaptured.localizedDescription)
                    } else {
                        self.createUserData(userEmailCaptured: userEmail,userNicknameCaptured: userNickname)
                        completion(nil)
                    }
                }
            }
        }
    }
    
    //MARK:- SignInViewController
    //MARK:- create new user
    private func createUserData(userEmailCaptured: String, userNicknameCaptured: String){
        let userData: [String:Any] = [
            "user_email":userEmailCaptured,
            "user_name": userNicknameCaptured
        ]
        let userRef = dataBase.collection("users")
        userRef.document(userEmailCaptured).setData(userData) { (error) in
            if let err = error{
                print("Error occured while creating user Data: \(err)")
            }
        }
    }
    
    private func userNameExists(_ userNickName: String, completion: @escaping (String?)->()) {
        let userNameRef = dataBase.collection("users")
        let query = userNameRef.whereField("user_name", isEqualTo: userNickName)
        query.getDocuments { (snapshot, error) in
            if let errorCaptured = error {
                print("Error while enquerying data: \(errorCaptured)")
                completion(errorCaptured.localizedDescription)
            }else{
                if let snapshotCaptured = snapshot {
                    if snapshotCaptured.documents.isEmpty{
                        completion(nil)
                    }else{
                        for document in snapshotCaptured.documents{
                            let userNameCaptured = document.data()["user_name"] as! String
                            if userNameCaptured == userNickName{
                                completion("Your Nickname has been occupied, please try a different name")
                            }else{
                                completion(nil)
                            }
                        }
                    }
                }else{
                    print("nothing found")
                    completion(nil)
                }
            }
        }
    }

    //MARK:- Sign In Method
    
    func signIn(_ userEmail: String, _ userPassword: String, completion: @escaping (String?)->()){
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (user, error) in
            if error != nil {
                completion(error?.localizedDescription)
            }
            else{
                completion(nil)
            }
        }
    }
    
    //MARK:- DashboardViewController
    //MARK:- Get current user Info methods

    func getCurrentUserName(completion: @escaping (String?)->()){
        if let currentUserEmail = Auth.auth().currentUser?.email {
            let userNameRef = dataBase.collection("users")
            let query = userNameRef.whereField("user_email", isEqualTo: currentUserEmail)
            query.getDocuments { (snapshot, error) in
                if let errorCaptured = error{
                    print("Error while querying userName: \(errorCaptured)")
                }
                else{
                    if let snapshotCaptured = snapshot {
                        for document in snapshotCaptured.documents{
                            let userName = document.data()["user_name"] as! String
                            completion(userName)
                        }
                    }
                }
            }
        }
    }
    
    //MARK:- Sign out
    func signOut(){
        do{
            try Auth.auth().signOut()
        }
        catch{
            print("Error, there was a problem while signing out")
        }
    }
    
    //MARK:- ProductEnqueryViewController
    //MARK:- retailer in product dataBase enquery methods
    
    private func enqueryRetailer(completion: @escaping ([String]?)->()) {
        var retailerList:[String] = [String]()
        dataBase.collection("products").getDocuments{ (querySnapshot, error) in
            if let error = error {
                print("Error while querying document id: \(error)")
                completion(nil)
            }else{
                if let snapshot = querySnapshot{
                    for document in snapshot.documents{
                        retailerList.append(document.data()["name"] as! String)
                        print(document.data()["name"] as! String)
                    }
                    completion(retailerList)
                }else{
                    completion(nil)
                }
            }
        }
    }
    
    //MARK:- Product in product database enquery metods
    
    func searchProduct(_ productNameQueried: String, completion: @escaping ([Product]?)->()) {
        var resultList: [Product] = [Product]()
        enqueryRetailer { (listOfRetailer) in
            if let listOfRetailer = listOfRetailer{
                for member in listOfRetailer{
                    let productQueryRef = self.dataBase.collection("products").document(member).collection("product_list")
                    let query = productQueryRef.whereField("key_words", arrayContains: productNameQueried)
                    query.getDocuments(completion: { (snapShot, error) in
                        if let error = error {
                            print("Error while querying products: \(error)")
                            completion(nil)
                        }else{
                            if let productSnapShot = snapShot{
                                for document in productSnapShot.documents{
                                    let productName = document.data()["product_name"]
                                    let productPrice = document.data()["product_price"]
                                    let productShopURL = document.data()["shop_url"]
                                    let productImageURL = document.data()["image_url"]
                                    let productCategories = document.data()["categories"]
                                    let prorductRetailer = document.data()["retailer"]
                                    let newProduct = Product(productName: productName as! String, productPrice: productPrice as! String, productImageURL: productImageURL as! String, productShoppingURL: productShopURL as! String, productCategories: productCategories as! [String], productRetailer: prorductRetailer as! String)
                                    resultList.append(newProduct)
                                }
                                completion(resultList)
                            }else{
                                completion(nil)
                            }
                        }
                    })
                    
                }
            }
        }
    }
    
    //MARK:- add to shopping list method
    
    func addToShoppingList(prodcut: Product, quantity: Int) {
        var data : [String : Any] = prodcut.castToDictionary()
        data["quantity"] = quantity
        data["done"] = false
        if let currentUserEmail = Auth.auth().currentUser?.email{
            let retailerRef = dataBase.collection("users").document(currentUserEmail).collection("shopping_list_by_retailers").document(data["retailer"] as! String)
            retailerRef.getDocument { (snapShot, error) in
                if let error = error{
                    print("Error while enquerying user's Retailer list: \(error)")
                }else{
                    retailerRef.setData(["name": data["retailer"] as! String])
                }
            }
            let userRef = dataBase.collection("users").document(currentUserEmail).collection("shopping_list_by_retailers").document(data["retailer"] as! String).collection("shopping_list").document(data["product_name"] as! String)
            userRef.getDocument { (docSnapshot, error) in
                if let error = error {
                    print("Error occured while reading shopping list: \(error)")
                }else{
                    if let existDocSnapshot = docSnapshot {
                        if let docData = existDocSnapshot.data(){
                            let newQuantity = docData["quantity"] as! Int + quantity
                            userRef.updateData(["quantity":newQuantity])
                        }else{
                            userRef.setData(data)
                        }
                    }
                }
            }
        }
    }
    
    //MARK:- ShoppingListByRetailerViewController
    //MARK:- Equery Retailers in Users' Shoppinglist
    
    func enqueryRetailersInShoppingList(completion: @escaping ([String]?)->()){
        var result:[String] = [String]()
        if let userEmail = Auth.auth().currentUser?.email{
            let retailersInUsersShoppingListRef = dataBase.collection("users").document(userEmail).collection("shopping_list_by_retailers")
            retailersInUsersShoppingListRef.getDocuments { (snapshot, error) in
                if let errorObtained = error{
                    print("Error while fetching retailers in User's Shopping list: \(errorObtained)")
                }else{
                    if let retailerSnapshot = snapshot{
                        if retailerSnapshot.documents.count == 0{
                            completion(nil)
                        }else{
                            for document in retailerSnapshot.documents{
                                result.append(document.data()["name"] as! String)
                            }
                            completion(result)
                        }
                    }else{
                        completion(nil)
                    }
                }
            }
        }
    }
    
    //MARK:- Finish the shoping list in this retailer and store to shopping history
    
    func deleteShoppingListByRetailerAndStoreToHistory(retailer: String, completion: @escaping (Error?)->()){
        if let userEmail = Auth.auth().currentUser?.email{
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: date)
            let shoppingListByRetailerRef = dataBase.collection("users").document(userEmail).collection("shopping_list_by_retailers").document(retailer).collection("shopping_list")
            let historyRef = dataBase.collection("users").document(userEmail).collection("history").document(result)
            historyRef.setData(["date":result])
            let historyShoppingListRef = historyRef.collection(retailer)
            shoppingListByRetailerRef.getDocuments { (snapshot, error) in
                if let errorObtained = error{
                    completion(errorObtained)
                }else{
                    if let productSnapshot = snapshot{
                        for document in productSnapshot.documents{
                            historyShoppingListRef.document(document.data()["product_name"] as! String).getDocument(completion: { (snapshot, error) in
                                if let errorObtained = error {
                                    print("Error obtained while fetching shopping history: \(errorObtained)")
                                }else{
                                    if let existDocSnapshot = snapshot {
                                        if let existQuantity = existDocSnapshot.data()?["quantity"]{
                                            let newQuantity = (existQuantity as! Int) + (document.data()["quantity"] as! Int)
                                            historyShoppingListRef.document(document.data()["product_name"] as! String).updateData(["quantity" : newQuantity])
                                        }else{
                                            historyShoppingListRef.document(document.data()["product_name"] as! String).setData(document.data())
                                        }
                                        shoppingListByRetailerRef.document(document.data()["product_name"] as! String).delete()
                                        
                                    }
                                }
                            })
                        }
                        shoppingListByRetailerRef.parent?.delete()
                    }
                    completion(nil)
                }
            }
        }
    }
    
    
    //MARK:- ShoppingListProductTableViewController
    //MARK:- Enquery todo shopping list under specific retailer
    
    func enqueryTodoShoppingList(at retailer: String, completion: @escaping ([ShoppingListItem]?)->()) {
        var resultList: [ShoppingListItem] = [ShoppingListItem]()
        if let userEmail = Auth.auth().currentUser?.email{
            let shoppingListRef = dataBase.collection("users").document(userEmail).collection("shopping_list_by_retailers").document(retailer).collection("shopping_list")
            shoppingListRef.getDocuments { (snapshot, error) in
                if let errorObtained = error{
                    print("Error while enquerying user's shopping List: \(errorObtained)")
                    completion(nil)
                }else{
                    if let dataObtained = snapshot{
                        for document in dataObtained.documents{
                            let productName = document.data()["product_name"]
                            let productPrice = document.data()["price_at_the_moment"]
                            let productShopURL = document.data()["shop_url"]
                            let productImageURL = document.data()["image_url"]
                            let productCategories = document.data()["categories"]
                            let prorductRetailer = document.data()["retailer"]
                            let quantity = document.data()["quantity"]
                            let done = document.data()["done"]
                            let newShoppingListItem = ShoppingListItem(productName: productName as! String, productPrice: productPrice as! String, productImageURL: productImageURL as! String, productShoppingURL: productShopURL as! String, productCategories: productCategories as! [String], productRetailer: prorductRetailer as! String, numbersOfItem: quantity as! Int, done: done as! Bool)
                            resultList.append(newShoppingListItem)
                        }
                        completion(resultList)
                    }else{
                        completion(nil)
                    }
                }
            }
        }
    }
    
    //MARK:- Delete Shoppinglist item function
    
    func deleteShoppingListItem(of productName: String, for retailer: String){
        if let userEmail = Auth.auth().currentUser?.email{
            let shoppingListItemRef = dataBase.collection("users").document(userEmail).collection("shopping_list_by_retailers").document(retailer).collection("shopping_list").document(productName)
            shoppingListItemRef.delete()
        }
    }
    
    //MARK:- CustomShoppingListItemTableViewCell
    //MARK:- Update shopping list item quantity to database
    func updateShoppingListItemQuantity(of productName:String, with quantity: Int, at retailer: String, completion: @escaping (Double?)->()){
        if let userEmail = Auth.auth().currentUser?.email{
            let shoppingListItemRef = dataBase.collection("users").document(userEmail).collection("shopping_list_by_retailers").document(retailer).collection("shopping_list").document(productName)
            shoppingListItemRef.updateData(["quantity": quantity])
            shoppingListItemRef.getDocument { (snapshot, error) in
                if let errorObtained = error{
                    print("Error while fetching shopping list item price: \(errorObtained)")
                    completion(nil)
                }else{
                    if let priceSnapshot = snapshot{
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .currency
                        formatter.locale = Locale(identifier: "en_US")
                        let price = Double(truncating: formatter.number(from: priceSnapshot.data()?["price_at_the_moment"] as! String) ?? 0)
                        completion(price * Double(quantity))
                    }
                }
            }
        }else{
            completion(nil)
        }
    }
    
    
    
}
