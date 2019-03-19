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

    @IBOutlet weak var logInUserEmail: UITextField!
    @IBOutlet weak var logInPassword: UITextField!
    
    private let dataBase = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        checkTextFieldsAndSignIn()
    }
    
    //MARK:- Check TextFields
    func checkTextFieldsAndSignIn(){
        let listOfTextFields: [UITextField] = [logInUserEmail, logInPassword]
        var errorIdentifier = true
        var listOfResults: [String] = [String]()
        for textField in listOfTextFields {
            if let result = textField.text, textField.text?.trimmingCharacters(in: .whitespaces) != ""{
                listOfResults.append(result)
                removeErrorHighlightTextField(textField: textField)
            }else{
                errorHighlightTextField(textField: textField)
                errorIdentifier = false
            }
        }
        if !errorIdentifier{
            generateSignInAlert(with: "Information Needed", and: "Please Complete High-Lighted field")
        }else{
            logIn(with: listOfResults)
        }
    }
    
    
    //MARK:- Alert generating method
    func generateSignInAlert(with title: String, and message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Highlight and Cancel highlight methods
    func errorHighlightTextField(textField: UITextField){
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
    }
    
    func removeErrorHighlightTextField(textField: UITextField){
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 5
    }
    
    //MARK:- login method
    
    func logIn(with listOfInfo: [String]) {
        let userEmail = listOfInfo[0]
        let userPassword = listOfInfo[1]
        dataBase.signIn(userEmail, userPassword) { (errorMessage) in
            if errorMessage != nil {
                print("Error occured while creating user: \(errorMessage!)")
                self.generateSignInAlert(with: "Invaild Sign In", and: errorMessage!)
                self.logInUserEmail.text = ""
                self.logInPassword.text = ""
            } else {
                self.performSegue(withIdentifier: "goToDash", sender: self)
            }
        }
    }
    
    
}
