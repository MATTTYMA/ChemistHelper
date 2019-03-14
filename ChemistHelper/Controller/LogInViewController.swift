//
//  LogInViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 12/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var logInUserName: UITextField!
    @IBOutlet weak var logInPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: logInUserName.text!, password: logInPassword.text!) { (user, error) in
            if error != nil {
                print("Error while log in to firebase \(error!)")
                // TODO : create log in error alert
            }else{
                self.performSegue(withIdentifier: "goToDash", sender: self)
            }
        }
        
        SVProgressHUD.dismiss()
    }
    
}
