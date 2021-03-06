//
//  ProfileViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 2/23/21.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var profession: UILabel!
    @IBOutlet weak var dni: UILabel!
    @IBOutlet weak var birthdate: UILabel!
    @IBOutlet weak var direction: UILabel!
    @IBOutlet weak var email: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.validateLogin()
        self.showInfoUser()
    }
    
    func showInfoUser(){
        let currentUser = self.dataUser.currentUser
        self.database.child("Usuario").queryOrdered(byChild:  "id").queryStarting(atValue: currentUser?.uid)
            .observeSingleEvent(of: .childAdded, with: { (snapshot: DataSnapshot) in

            
            let user = snapshot.value as! [String: AnyObject]
            self.fullName.text = "\(user["nombre"] as? String ?? "") \(user["apellidos"] as? String ?? "")"
            self.dni.text = user["dni"] as? String ?? ""
            self.profession.text = user["profesion"] as? String ?? ""
            self.birthdate.text = user["fecha_nacimiento"] as? String ?? ""
            self.direction.text = user["direccion"] as? String ?? ""
            self.email.text = user["email"] as? String ?? ""
        })
        
    }
    
    
    func validateLogin(){
        if self.dataUser?.currentUser == nil {
            self.showStoryboardLogin()
        }
    }
    
    @IBAction func showProfileEdit(_ sender: Any) {
        self.performSegue(withIdentifier: "ProfileEdit", sender: self)
        
    }
    
    
    

}
