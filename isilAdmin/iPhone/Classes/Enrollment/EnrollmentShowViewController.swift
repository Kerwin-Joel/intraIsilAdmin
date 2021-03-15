//
//  EnrollmentShowViewController.swift
//  isilAdmin
//
//  Created by user178488 on 3/15/21.
//

import UIKit

class EnrollmentShowViewController: UIViewController{
    var obj: EnrollmentBE!
    
   /*@IBOutlet weak var lblCourse :UILabel!
    
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
    }*/
}

    
    extension EnrollmentShowViewController: UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //let brandCar = self.arrayAutos[section]
            //return brandCar.count
            //self.arrayNombres.count
            
            return 5
            
            /*return self.arrayEnrollment.count*/
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cellIdentifier = "EnrollmentShowViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EnrollmentShowViewCell
            //cell.objPlace = self.arrayEnrollment[indexPath.row]
            
            
            let r = CGFloat.random(in: 0...255)/255
            let g = CGFloat.random(in: 0...255)/255
            let b = CGFloat.random(in: 0...255)/255
            let color = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1)
            cell.backgroundColor = color
            
            return cell
        }
    }

    extension EnrollmentShowViewController: UITableViewDelegate{
        
        }
    
