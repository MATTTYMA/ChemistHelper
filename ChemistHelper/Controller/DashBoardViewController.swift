//
//  DashBoardViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 12/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import SVProgressHUD

class DashBoardViewController: UIViewController {
    
    private let dataBase = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dataBase.getCurrentUserName()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        
        dataBase.signOut()
        
        guard (navigationController?.popViewController(animated: true)) != nil
            else{
                print("No View Controller to pop off")
                return
        }
    }
    
    @IBAction func goToProductEnqueryButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToProductEnquery", sender: self)
    }
    
    @IBAction func goToShoppingListButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToShoppingList", sender: self)
    }
    
    //    @IBAction func testSearchButtonPressed(_ sender: Any) {
//
//        let productDB = Firestore.firestore()
//        let productRef = productDB.collection("Products").document("ChemistWarehouse").collection("product_list")
//        let query = productRef.whereField("product_name", isEqualTo: testInPut.text!)
//        query.getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Error while quering data: \(error)")
//            }else{
//
//                if let snapshot = snapshot {
//
//                    for document in snapshot.documents{
//                        print(document.data()["product_name"] as! String)
//                    }
//                }else{
//                    print("Nothing found here")
//                }
//            
//            }
//
//        }
//
//
//    }
//
    
}
