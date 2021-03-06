//
//  viewController.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 1/03/21.
//


import UIKit
import Firebase
import FirebaseAuth

extension UIViewController{

    weak var database: DatabaseReference! {
        return Database.database().reference().child("IntraIsil")
    }
    weak var dataUser: Auth!{
        return Auth.auth()
    }
    
    /*func instantiateDataBase() -> Any {
        return Database.database().reference().child("IntraIsil")
    }
    func instantiateDataUser() -> Any {
        return Auth.auth()
    }*/
    
    @IBAction func signOut(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                self.showStoryboardLogin()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    public func showStoryboardLogin(){
        guard let controller = self.navigationController?.viewControllers.first(where: {
            $0 is LoginViewController
        }) else { return }
        
        self.navigationController?.popToViewController(controller, animated: true)
        
    }
}
