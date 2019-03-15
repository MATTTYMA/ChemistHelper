//
//  DataBase.swift
//  ChemistHelper
//
//  Created by MATTEW MA on 15/3/19.
//  Copyright © 2019 Mathhew MA. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class DataBase{
    
    private let dataBase = Firestore.firestore()
    
    // MARK:- Sign On methods
    
    func signOn(userName: String, userPassword: String, completion: @escaping (String?)->())  {
        Auth.auth().createUser(withEmail: userName, password: userPassword) { (user, error) in
            if error != nil {
                completion(error?.localizedDescription)
            } else {
                self.createUserData(userName: userName)
                completion(nil)
            }
        }
    }
    
    private func createUserData(userName: String){
        let userData: [String:Any] = [
            "user_name":userName,
            "user_shopping_list":[String]()
        ]
        let userRef = dataBase.collection("user")
        userRef.document().setData(userData) { (error) in
            if let err = error{
                print("Error occured while creating user Data: \(err)")
            }
        }
    }

    //MARK:- Sign In/Out Method
    
    func signIn(userName: String, userPassword: String, completion: @escaping (String?)->()){
        Auth.auth().signIn(withEmail: userName, password: userPassword) { (user, error) in
            if error != nil {
                completion(error?.localizedDescription)
            }
            else{
                completion(nil)
            }
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
        }
        catch{
            print("Error, there was a problem while signing out")
        }
    }
    
    //MARK:- Check log in statue method
    
    func hasLogin() -> Bool {
        if Auth.auth().currentUser != nil{
            return true
        } else {
            return false
        }
    }
    
    func getCurrentUserName() -> String{
        if let currentUserName =  Auth.auth().currentUser?.email {
            return currentUserName
        }
        return ""
    }
}
