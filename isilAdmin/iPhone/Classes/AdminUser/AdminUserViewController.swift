//
//  AdminUserViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 2/23/21.
//

import UIKit
import Firebase

class AdminUserViewController: UIViewController {

    
    @IBOutlet weak var fullName: UILabel!
    
    //var database: Any
    //var dataUser: AnyObject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.database = self.instantiateDataBase()
        //self.dataUser = self.instantiateDataUser() as AnyObject
        
        self.validateLogin()
        self.showInfoUser()
        
    }
    
    func validateLogin(){
        if self.dataUser?.currentUser == nil {
            self.showStoryboardLogin()
        }
    }
    
    func showInfoUser(){
        let strSearch = self.dataUser.currentUser?.uid

        self.database.child("Usuario").queryOrdered(byChild:  "id").queryStarting(atValue: strSearch)
            .observeSingleEvent(of: .childAdded, with: { (snapshot: DataSnapshot) in

            let user = snapshot.value as! [String: AnyObject]
            self.fullName.text = "\(user["nombre"] as? String ?? "") \(user["apellidos"] as? String ?? "")"

        })
    }
    
    @IBAction func showProfile(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Profile", sender: self)
    }
    
    @IBAction func showCareers(_ sender: Any) {
        self.performSegue(withIdentifier: "Careers", sender: self)
    }
    
    @IBAction func showCourses(_ sender: Any) {
        self.performSegue(withIdentifier: "Courses", sender: self)
    }
    
    @IBAction func showLocations(_ sender: Any) {
        self.performSegue(withIdentifier: "Locations", sender: self)
    }
    
    @IBAction func showStudents(_ sender: Any) {
        self.performSegue(withIdentifier: "Students", sender: self)
    }
    
    @IBAction func showEnrollment(_ sender: Any) {
        self.performSegue(withIdentifier: "Enrollment", sender: self)
    }
    

}
