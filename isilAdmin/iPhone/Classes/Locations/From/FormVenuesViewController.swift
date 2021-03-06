//
//  FromVenuesViewController.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//

import Foundation
import UIKit

class FormVenuesViewController: UIViewController{
    var obj: CampusBE!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    var msj = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(obj != nil) { self.showInformation() }
        else { self.clearFields() }
        self.lblTitle.text = (obj != nil) ? "ACTUALIZAR SEDE" : "AGREGAR SEDE"
    }
    
    func showInformation(){
        self.name.text = obj.nombre
    }
    func clearFields(){
        self.name.text = ""
    }
    
    @IBAction func eventSave(_ sender: UIButton) {
        if(self.validate()){
            if(obj != nil){ self.edit() }
            else{ self.save() }
        }
        else { self.showAlertMessage() }
    }
    
    func validate() -> Bool{
        let _name = self.name.text?.trimmingCharacters(in: .whitespaces)
        if(_name!.count == 0){ self.msj = "El nombre es requerido"}
        else { self.msj = "" }
        return (self.msj.count == 0) ? true : false
    }
    
    func save(){
        
        let objet: [String: Any] = [
            "nombre": self.name.text,
            "fecha": self.getDate(),
            "estado": 1
        ]
        self.database.child("Sedes").childByAutoId().setValue(objet)
        self.navigationController?.popViewController(animated: true)
    }
    
    func edit(){
        let objet: [String: Any] = [
            "nombre": self.name.text,
            "fecha": self.getDate(),
            "estado": 1
        ]
        self.database.child("Sedes/\(obj.id)").setValue(objet)
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDate() -> Any{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func showAlertMessage(){
        let alert = UIAlertController(title: "¡Error!", message: self.msj, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
