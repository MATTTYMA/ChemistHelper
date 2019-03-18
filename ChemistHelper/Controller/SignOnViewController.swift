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

    @IBOutlet weak var registerUserEmail: UITextField!
    @IBOutlet weak var registerUserPassword: UITextField!
    @IBOutlet weak var registerConfirmPassword: UITextField!
    @IBOutlet weak var registerNickname: UITextField!
    
    private let dataBase = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
        checkTextFieldsAndSignOn()
    }
    
    //MARK: Alert generating method
    func generateSignOnAlert(with title: String, and message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Check TextFields
    func checkTextFieldsAndSignOn(){
        let listOfTextFields: [UITextField] = [registerUserEmail,registerUserPassword, registerConfirmPassword,registerNickname]
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
            generateSignOnAlert(with: "Information Needed", and: "Please Complete High-Lighted field")
        }else{
            signOn(with: listOfResults)
        }
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
    
    //MARK:- Sign on and perform segue Method
    func signOn(with listOfInfo: [String]) {
        let userEmail = listOfInfo[0]
        let userPassword = listOfInfo[1]
        let userNickname = listOfInfo[3]
        dataBase.signOn(userEmail, userPassword, userNickname) { (errorMessage) in
            if errorMessage != nil{
                print("Error occured while creating user: \(errorMessage!)")
                self.generateSignOnAlert(with: "Invaild Sign ON", and: errorMessage!)
                self.registerUserEmail.text = ""
                self.registerUserPassword.text = ""
            } else {
                self.performSegue(withIdentifier: "goToDash", sender: self)
            }
        }
    }

}
