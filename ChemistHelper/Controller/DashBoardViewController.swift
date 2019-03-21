//
//  DashBoardViewController.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 12/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import UIKit
import SVProgressHUD

class DashBoardViewController: UIViewController {
    
    private let dataBase = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBase.getCurrentUserName { (user) in
            if let userName = user{
                self.title = userName
            }
        }
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
    
    @IBAction func goToProductEnqueryButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToProductEnquery", sender: self)
    }
    
    @IBAction func goToShoppingListButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToShoppingList", sender: self)
    }
    

    
}
