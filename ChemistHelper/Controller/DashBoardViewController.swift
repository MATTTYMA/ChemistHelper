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

    @IBOutlet weak var testInPut: UITextField!
    @IBOutlet weak var testDisplay: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Auth.auth().currentUser?.email
        
    }
    
    
    @IBAction func testSearchButtonPressed(_ sender: Any) {
        
        let productDB = Firestore.firestore()
        let productRef = productDB.collection("Products").document("ChemistWarehouse").collection("product_list")
        let query = productRef.whereField("product_name", isEqualTo: testInPut.text!)
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error while quering data: \(error)")
            }else{
                SVProgressHUD.show()
                if let snapshot = snapshot {
                    
                    for document in snapshot.documents{
                        print(document.data()["product_name"] as! String)
                    }
                }else{
                    print("Nothing found here")
                }
                SVProgressHUD.dismiss()
            }
           
        }
        
        
    }
    
    
}
