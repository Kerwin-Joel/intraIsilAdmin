//
//  AddStudentViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 3/2/21.
//

import UIKit
import Firebase

class AddStudentViewController: UIViewController {
    
    var numberUser:String?
    @IBOutlet weak var nameStudent: UITextField!
    @IBOutlet weak var lastNameStudent: UITextField!
    @IBOutlet weak var birthdayStudent: UITextField!
    @IBOutlet weak var carrerStudent: UITextField!
    @IBOutlet weak var DNIStudent: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addStudent(_ sender: Any) {
        
        let alumnoNombre = nameStudent.text ?? ""
        let alumnoApellido = lastNameStudent.text ?? ""
        let alumnoNacimiento = birthdayStudent.text ?? ""
        let alumnoCarrera = carrerStudent.text ?? ""
        let alumnoDni = DNIStudent.text ?? ""
                
        let objet: [String: Any] = ["alumno": alumnoNombre,
                                    "apellido": alumnoApellido,
                                    "nacimiento" : alumnoNacimiento,
                                    "carrera" : alumnoCarrera,
                                    "dni" : alumnoDni]

            
        self.database.child("alumnos").getData { (error, DataSnapshot) in
            self.numberUser = String(DataSnapshot.childrenCount)
            if error == nil{
                self.database.child("alumnos").child("user-\(self.numberUser ?? "")").setValue(objet)
            }
        }

    }
    
    
}
