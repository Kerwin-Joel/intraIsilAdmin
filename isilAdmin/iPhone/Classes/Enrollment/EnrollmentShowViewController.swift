//
//  EnrollmentShowViewController.swift
//  isilAdmin
//
//  Created by user178488 on 3/15/21.
//

import UIKit

class EnrollmentShowViewController: UIViewController{
    var obj: EnrollmentBE!
    
    @IBOutlet weak var lblCourse :UILabel!
    
    var msj = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(obj != nil) { self.showInformation() }
        else { self.clearFields() }
        /*self.lblTitle.text = (obj != nil) ? "ACTUALIZAR SEDE" : "AGREGAR SEDE"*/
    }
    
    func showInformation(){
        self.lblCourse.text = obj.place_Course
        
    }
    func clearFields(){
        self.lblCourse.text = ""
    }
    
    
}
