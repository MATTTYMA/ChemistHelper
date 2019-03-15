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
    
    private let dataBase = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
        dataBase.signOn(userName: registerUserName.text!, userPassword: registerUserPassword.text!) { (errorMessage) in
            if errorMessage != nil{
                print("Error occured while creating user: \(errorMessage!)")
                let alert = UIAlertController(title: "Invaild Sign On", message: errorMessage, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.registerUserName.text = ""
                self.registerUserPassword.text = ""
            } else {
                self.performSegue(withIdentifier: "goToDash", sender: self)
            }
        }
    }
    

}
