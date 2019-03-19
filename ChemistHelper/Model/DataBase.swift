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
    
    func signOn(_ userEmail: String, _ userPassword: String, _ userNickname: String, completion: @escaping (String?)->())  {
        self.userNameExists(userNickName: userNickname) { (error) in
            if let userNameExistError = error{
                completion(userNameExistError)
            }else{
                Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (user, error) in
                    if let errorCaptured = error {
                        completion(errorCaptured.localizedDescription)
                    } else {
                        self.createUserData(userEmailCaptured: userEmail,userNicknameCaptured: userNickname)
                        completion(nil)
                    }
                }
            }
        }
    }
    
    private func createUserData(userEmailCaptured: String, userNicknameCaptured: String){
        let userData: [String:Any] = [
            "user_email":userEmailCaptured,
            "user_name": userNicknameCaptured
        ]
        let userRef = dataBase.collection("users")
        userRef.document().setData(userData) { (error) in
            if let err = error{
                print("Error occured while creating user Data: \(err)")
            }
        }
    }
    
    private func userNameExists(userNickName: String, completion: @escaping (String?)->()) {
        let userNameRef = dataBase.collection("users")
        let query = userNameRef.whereField("user_name", isEqualTo: userNickName)
        query.getDocuments { (snapshot, error) in
            if let errorCaptured = error {
                print("Error while enquerying data: \(errorCaptured)")
                completion(errorCaptured.localizedDescription)
            }else{
                if let snapshotCaptured = snapshot {
                    if snapshotCaptured.documents.isEmpty{
                        completion(nil)
                    }else{
                        for document in snapshotCaptured.documents{
                            let userNameCaptured = document.data()["user_name"] as! String
                            if userNameCaptured == userNickName{
                                completion("Your Nickname has been occupied, please try a different name")
                            }else{
                                completion(nil)
                            }
                        }
                    }
                }else{
                    print("nothing found")
                    completion(nil)
                }
            }
        }
    }

    //MARK:- Sign In/Out Method
    
    func signIn(_ userEmail: String, _ userPassword: String, completion: @escaping (String?)->()){
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (user, error) in
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
    
    //MARK:- Get current user Info methods

    func getCurrentUserName(completion: @escaping (String?)->()){
        if let currentUserEmail = Auth.auth().currentUser?.email {
            let userNameRef = dataBase.collection("users")
            let query = userNameRef.whereField("user_email", isEqualTo: currentUserEmail)
            query.getDocuments { (snapshot, error) in
                if let errorCaptured = error{
                    print("Error while querying userName: \(errorCaptured)")
                }
                else{
                    if let snapshotCaptured = snapshot {
                        for document in snapshotCaptured.documents{
                            let userName = document.data()["user_name"] as! String
                            completion(userName)
                        }
                    }
                }
            }
        }
    }
    
    
}
