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
    
    private let dataBase = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        dataBase.signIn(userName: logInUserName.text!, userPassword: logInPassword.text!) { (errorMessage) in
            if errorMessage != nil {
                print("Error occured while creating user: \(errorMessage!)")
                let alert = UIAlertController(title: "Invaild Sign In", message: errorMessage, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.logInUserName.text = ""
                self.logInPassword.text = ""
            } else {
                self.performSegue(withIdentifier: "goToDash", sender: self)
            }
        }
        
    }
    
}
