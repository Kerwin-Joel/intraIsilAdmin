//
//  UpdateStudentViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 3/3/21.
//

import UIKit
import Firebase

class UpdateStudentViewController: UIViewController {

    var id:String!
    var alumnos :[Student] = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alumnos                 = [Student]()
        print("data traida desde list \(id ?? "")")
        
        self.database.child("alumnos").observe(.value, with:{ snapshot in
            let dicRot = snapshot.value as? [String : AnyObject] ?? [:]
            for key in Array(dicRot.keys){
                self.alumnos.append(Student(dictionary: dicRot[key] as! [String:AnyObject] , key: key))
            }
            
            print(dicRot)
            
        })
    }
    
    

}
