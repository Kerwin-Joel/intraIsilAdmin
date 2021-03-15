//
//  AddScheduleViewController.swift
//  isilAdmin
//
//  Created by Christopher Pinillos Collazos on 8/03/21.
//

import UIKit

class AddScheduleViewController: UIViewController {

    var obj: CourseBE!
    var numberSchedule: String?
    
    
    @IBOutlet weak var txtHoraInicio: UITextField!
    @IBOutlet weak var txtDuracion: UITextField!
    @IBOutlet weak var txtDia: UITextField!
    @IBOutlet weak var txtAula: UITextField!
    @IBOutlet weak var txtProfe: UITextField!
    @IBOutlet weak var txtSede: UITextField!
    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    
    @IBAction func clickCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePickerView()
        if (obj != nil) {
            self.txtProfe.text = obj.teacher
        } else {
            print("No avances mas papu")
        }

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
    
    func createDatePickerView(){
       
       txtHoraInicio.textAlignment = .center
       let toolbar = UIToolbar()
       toolbar.sizeToFit()
       
       let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.endPressed))
       
       toolbar.setItems([doneBtn], animated: true)
       
       self.txtHoraInicio.inputAccessoryView = toolbar
       self.txtHoraInicio.inputView = datePicker
        datePicker.datePickerMode = .time
       
   }
   
   //Funcion del boton
   @objc func endPressed(){
       
       self.view.endEditing(true)
       let dataformatter = DateFormatter()
        dataformatter.dateFormat = "hh:mm aa"
       self.txtHoraInicio.text = dataformatter.string(from: datePicker.date)
       
   }
    
    
    
    
    @IBAction func addSchedule(_ sender: Any) {
        let hora = txtHoraInicio.text ?? ""
        let duracion = txtDuracion.text ?? ""
        let dia = txtDia.text ?? ""
        let aula = txtAula.text ?? ""
        let profe = txtProfe.text ?? ""
        let sede = txtSede.text ?? ""
        let id = obj.id
        
        
        let object: [String:Any] = ["dia":dia,
                                    "hora": hora,
                                    "duracion": duracion,
                                    "aula": aula,
                                    "profesor": profe,
                                    "sede": sede]
        
        self.database.child("Cursos/\(id)/detalles").getData{ (error, snapshop) in
            self.numberSchedule = String(snapshop.childrenCount)
            if error == nil{
                self.database.child("Cursos/\(id)/detalles/horario-\(self.numberSchedule ?? "")").setValue(object)
               
            }
        }
    }
}
