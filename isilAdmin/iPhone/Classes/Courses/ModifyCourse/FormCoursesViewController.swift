//
//  FormCoursesViewController.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//


import UIKit
import Foundation

class FormCoursesViewController: UIViewController {
    
    var obj: CourseBE!
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtCarrera: UITextField!
    @IBOutlet weak var txtCodigo: UITextField!
    @IBOutlet weak var txtProfe: UITextField!
    @IBOutlet weak var txtUrlImage: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var constrainBottomScroll: NSLayoutConstraint!
    
    @IBAction func clickCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePickerView()
        if (obj != nil) {
            self.showInformation()
        }
    }
    
    func showInformation(){
        self.txtNombre.text = obj.name
        self.txtCarrera.text = obj.career
        self.txtCodigo.text = obj.code
        self.txtProfe.text = obj.teacher
        self.txtUrlImage.text = obj.urlImage
        self.txtDate.text = obj.date
    }
    
    
    @IBAction func updateCourse(_ sender: Any) {
        self.update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?CGRect ?? .zero
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as?Double ?? 0
        
        UIView.animate(withDuration: animationDuration){
            self.constrainBottomScroll.constant = keyboardFrame.size.height - 90 //90 el tamaño del ultimo view
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notificacion: Notification){
        let animationDuration = notificacion.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as?Double ?? 0
        UIView.animate(withDuration: animationDuration){
            self.constrainBottomScroll.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    //Crear el toolbar con el boton y el datepicker
     func createDatePickerView(){
        
        txtDate.textAlignment = .center
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.endPressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        self.txtDate.inputAccessoryView = toolbar
        self.txtDate.inputView = datePicker
        datePicker.datePickerMode = .date
        
    }
    
    //Funcion del boton
    @objc func endPressed(){
        
        self.view.endEditing(true)
        let dataformatter = DateFormatter()
        dataformatter.dateFormat = "dd-MM-YYYY"
        self.txtDate.text = dataformatter.string(from: datePicker.date)
        
    }
    
    func update(){
        let object:[String: Any] = [
            "nombre": self.txtNombre.text ?? "",
            "carrera": self.txtCarrera.text ?? "",
            "codigo": self.txtCodigo.text ?? "",
            "profesor": self.txtProfe.text ?? "",
            "urlImage": self.txtUrlImage.text ?? "",
            "fecha": self.txtDate.text ?? ""
        ]
        
        
        if txtNombre.text == "" || txtCarrera.text == "" || txtCodigo.text == "" || txtProfe.text == "" || txtUrlImage.text == "" || txtDate.text == "" {
            let alert = UIAlertController(title: "Error", message: "Rellene los campos faltantes", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            
            self.database.child("Cursos/\(obj.id)").updateChildValues(object)
            self.navigationController?.popViewController(animated: true)
            
        }
    }
}
