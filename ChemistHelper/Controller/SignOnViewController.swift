//
//  SignOnViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 12/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseFirestore

class SignOnViewController: UIViewController {

    @IBOutlet weak var registerUserName: UITextField!
    @IBOutlet weak var registerUserPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: registerUserName.text!, password: registerUserPassword.text!) { (user, error) in
            if error != nil {
                print("Error occured while creating user: \(error!)")
                let alert = UIAlertController(title: "Invaild Sign On", message: error?.localizedDescription, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.registerUserName.text = ""
                self.registerUserPassword.text = ""
            }else{
                self.performSegue(withIdentifier: "goToDash", sender: self)
                self.createUserInfo(userName: self.registerUserName.text!)
            }
        }
        
        SVProgressHUD.dismiss()
    }
    
    func createUserInfo(userName:String){
        let userData: [String:Any] = [
            "user_name":userName,
            "user_shopping_list":[String]()
        ]
        
        let userDB = Firestore.firestore()
        userDB.collection("user").document().setData(userData) { (error) in
            if let err = error{
                print("Error occured while creating user Data: \(err)")
            }
        }
    }
    

}
