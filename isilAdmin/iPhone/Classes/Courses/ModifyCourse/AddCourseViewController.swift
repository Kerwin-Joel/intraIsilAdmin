//
//  AddCoursesViewController.swift
//  isilAdmin
//
//  Created by Christopher Pinillos Collazos on 4/03/21.
//

import UIKit
import Firebase

class AddCourseViewController: UIViewController {
    
    
    @IBOutlet weak var txtnombreCurso: UITextField!
    @IBOutlet weak var txtnombreCarrera: UITextField!
    @IBOutlet weak var txtcodigoCurso: UITextField!
    @IBOutlet weak var txtnombreProfe: UITextField!
    @IBOutlet weak var txturlImage: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    
    //Ocultar el teclado en el Scroll
    @IBAction func clickCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePickerView()

    }
    
    // Codigo para añadir y remover el observador del teclado
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
            self.constraintBottomScroll.constant = keyboardFrame.size.height - 90 //90 el tamaño del ultimo view
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notificacion: Notification){
        let animationDuration = notificacion.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as?Double ?? 0
        UIView.animate(withDuration: animationDuration){
            self.constraintBottomScroll.constant = 0
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
    
    
    
    //Funcion para añadir cursos a la base de datos
    @IBAction func addCourses(_ sender: Any) {
        
        let nombreCurso = txtnombreCurso.text ?? ""
        let nombreCarrera = txtnombreCarrera.text ?? ""
        let codigoCurso = txtcodigoCurso.text ?? ""
        let nombreProfe = txtnombreProfe.text ?? ""
        let image = txturlImage.text ?? ""
        let date = txtDate.text ?? ""
        let object: [String: Any] = ["estado":"1",
                                     "nombre":nombreCurso,
                                     "carrera":nombreCarrera,
                                     "codigo":codigoCurso,
                                     "profesor":nombreProfe,
                                     "fecha":date,
                                     "urlImage": image]
        
        
        //Mensaje alerta rellenar campos vacios
        if nombreCurso == "" || nombreCarrera == "" || codigoCurso == "" || nombreProfe == ""  {
            let alert = UIAlertController(title: "Error", message: "Rellene los campos faltantes", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            self.database.child("Cursos").getData {( error, Snapshot) in
                if error == nil {
                    //Relleno de base de datos child Cursos con ID aleatoria
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
