//
//  AddCoursesViewController.swift
//  isilAdmin
//
//  Created by user178488 on 3/10/21.
//

import UIKit

class AddCoursesViewController: UIViewController{
    
    @IBOutlet weak var ConstraintBottom: NSLayoutConstraint!
    
    @IBOutlet weak var ConstraintCentreYViewContent: NSLayoutConstraint!
    @IBAction func clickBtnCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            self.ConstraintBottom.constant = keyboardFrame.size.height - 90 //90 el tamaño del ultimo view
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notificacion: Notification){
        let animationDuration = notificacion.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as?Double ?? 0
        UIView.animate(withDuration: animationDuration){
            self.ConstraintBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
