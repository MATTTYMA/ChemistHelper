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
                // TODO : create warning of error
            }else{
                self.performSegue(withIdentifier: "goToDash", sender: self)
                // TODO : creating empty user INFO data on Firebase
            }
        }
        
        SVProgressHUD.dismiss()
    }
    

}
