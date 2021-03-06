//
//  UpdateProfileViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 3/2/21.
//

import UIKit
import Firebase
import FirebaseAuth

class UpdateProfileViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showInfoUser()
    
    }
    
    func showInfoUser(){
        let currentUser = self.dataUser.currentUser
        
        self.database.child("Usuario").queryOrdered(byChild:  "id").queryStarting(atValue: currentUser?.uid)
            .observeSingleEvent(of: .childAdded, with: { (snapshot: DataSnapshot) in

            
            let user = snapshot.value as! [String: AnyObject]
            print(user)
        })
        
    }

    
    
}







//    //        self.uidUsuer = Auth.auth().currentUser?.uid ?? ""
//
//            let objet: [String: Any] = [
//                                    "curso_id": "dddd",
//                                    "estado": 1
//                                    ]
//    //        self.database.child("prueba1/detalles").child((Auth.auth().currentUser?.uid)!).get(objet)
//
//            let currentUser = Auth.auth().currentUser
//    //
//            self.database.child("Persona").queryOrdered(byChild:  "id").queryStarting(atValue: currentUser?.uid)
//                .observeSingleEvent(of: .childAdded, with: { (snapshot: DataSnapshot) in
//
//
//                let user = snapshot.value as! [String: AnyObject]
//                    print(user)
//    //                print(currentUser?.email ?? "")
//    //
//    //            self.database.child("prueba1/detalles").child((Auth.auth().currentUser?.uid)!).setValue(objet)
//
//            })
//
//
//            self.database.child("IntraIsil").child("Usuario").queryOrdered(byChild:  "id").queryStarting(atValue: currentUser?.uid)
//                .observeSingleEvent(of: .childAdded, with: { (snapshot: DataSnapshot) in
//
//
//                let user = snapshot.value as! [String: AnyObject]
//    //            self.email.text = user["email"] as? String ?? ""
//                    print(user)
//            })
//
//
//
//        }
