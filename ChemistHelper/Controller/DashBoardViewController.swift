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
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        dataBase.getCurrentUserName { (user) in
            if let userName = user{
                self.title = userName
                SVProgressHUD.dismiss()
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
        self.performSegue(withIdentifier: "goToRetailerList", sender: self)
    }
    
   
    
    @IBAction func goToShoppingHistoryPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToShoppingHistoryCalendar", sender: self)
    }
    
    
}
