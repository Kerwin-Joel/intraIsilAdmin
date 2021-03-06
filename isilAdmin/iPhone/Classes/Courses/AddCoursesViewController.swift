//
//  AddCoursesViewController.swift
//  isilAdmin
//
//  Created by Christopher Pinillos Collazos on 4/03/21.
//

import UIKit
import Firebase

class AddCoursesViewController: UIViewController {
    
    
    @IBOutlet weak var txtnombreCurso: UITextField!
    @IBOutlet weak var txtnombreCarrera: UITextField!
    @IBOutlet weak var txtcodigoCurso: UITextField!
    @IBOutlet weak var txtnombreProfe: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addCourses(_ sender: Any) {
        
        let nombreCurso = txtnombreCurso.text
        let nombreCarrera = txtnombreCarrera.text
        let codigoCurso = txtcodigoCurso.text
        let nombreProfe = txtnombreProfe.text
        let image = "https://picsum.photos/768/432" //Imagenes Random *no seguro si funciona*
        let object: [String: Any] = ["estado":1,
                                     "nombre":nombreCurso,
                                     "carrera":nombreCarrera,
                                     "codigo":codigoCurso,
                                     "profesor":nombreProfe,
                                     "urlimage": image]
        
        
        //Mensaje alerta rellenar campos vacios
        if nombreCurso == "" || nombreCarrera == "" || codigoCurso == "" || nombreProfe == ""  {
            let alert = UIAlertController(title: "Error", message: "Rellene los campos faltantes", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            self.database.child("Cursos").getData {( error, Snapshot) in
                if error == nil {
                    //Relleno de base de datos child Cursos con clave aleatoria
                    self.database.child("Cursos").childByAutoId().setValue(object)
                } else {
                    //Mensaje error conectividad base de datos
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
