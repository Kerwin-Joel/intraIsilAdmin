//
//  EnrollmentShowViewController.swift
//  isilAdmin
//
//  Created by user178488 on 3/15/21.
//

import UIKit
import Firebase
import FirebaseAuth


class EnrollmentShowViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var arrayEnrollment = [EnrollmentBE]()
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
    
   /* func cargarTabla(){
      self.database.child("Matriculas/\(snapshot.key)/detalles").observe(.value, with: {(snapshot) in }
      //self.database.child("Matriculas").observe(.value, with: { (snapshot) in

          if snapshot.childrenCount > 0 {
              self.arrayEnrollment.removeAll()
              for data in snapshot.children.allObjects as! [DataSnapshot] {
                  
                  print("data", data)
                  let json = data.value as! [String: Any]
                  let enroll = EnrollmentBE(id: data.key,
                                            student: json["Alumno"] as! String,
                                            career:  json["horario1"] as! String)
                  

                  self.arrayEnrollment.append(enroll)
              }

              DispatchQueue.main.async {
                  self.tableView.reloadData()
              }
              
          }
      
    })
  
}
*/
}


    extension EnrollmentShowViewController: UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //let brandCar = self.arrayAutos[section]
            
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
  




















/*class EnrollmentShowViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var schedule: UILabel!
    
    
    
    @IBOutlet weak var tableView: UITableView!

    var database = Database.database().reference().child("IntraIsil")
    var arrayDetails = [DetailsBE]()

    var objDetail: DetailsBE!
    
    var uidUser: String?
    var iddetail: String?
    var namedate: String?
    var nameschedule: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.date.text = namedate ?? ""
        self.schedule.text = nameschedule ?? ""
        self.uidUser = Auth.auth().currentUser?.uid ?? ""
        self.cargarTabla()
    }
    
    func cargarTabla(){
        
        self.database.child("Matriculas").child(self.uidUser ?? "").observe(.value, with: { (snapshot) in

            if snapshot.childrenCount > 0 {
                self.arrayDetails.removeAll()
                
                let media = snapshot.value as! [String : Any]
                for childSnapshot in media["detalles"] as! JSON {
                    let details = DetailsBE(json: childSnapshot.value as! JSON, idDetail: childSnapshot.key)
                    self.arrayDetails.append(details)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        })
        
    }
    
}

extension EnrollmentShowViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EnrollmentShowViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EnrollmentShowViewCell
        cell.objDetail = self.arrayDetails[indexPath.row]
        
        let r = CGFloat.random(in: 0...255)/255
        let g = CGFloat.random(in: 0...255)/255
        let b = CGFloat.random(in: 0...255)/255
        let color = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1)
        cell.backgroundColor = color
        
        return cell
    }
    

    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.arrayDetails[indexPath.row]
        
        let alert = UIAlertController(title: "¡Alerta!", message: "¿Desea matricularse en el horario de \(obj.day) a las \(obj.hours)?", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Si, matricular", style: UIAlertAction.Style.default, handler: {action in
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy"
                    let objet: [String: Any] = [
                        "curso_id": self.idCourse!,
                        "estado": 1,
                        "fecha": formatter.string(from: date),
                        "horario": obj.idSchedule
                    ]
                    /*
                     "detalles":[
                         "curso_id": self.idCourse!,
                         "estado": 1,
                         "fecha": formatter.string(from: date),
                         "horario": obj.idSchedule
                     ]
                     **/
     
                    self.database.child("Matriculas").queryOrdered(byChild: "usuario_id").queryStarting(atValue: self.uidUsuer).observeSingleEvent(of: .childAdded) { (snapshot) in
                        
                        guard snapshot.exists() != false else {
                            return
                        }
                        
                        DispatchQueue.main.async {
                            guard let dict = snapshot.value as? [String:Any] else {
                                return
                            }
                            
                            self.database.child("Matriculas/\(snapshot.key)/detalles").childByAutoId().setValue(objet)
                            
                            guard let controller = self.navigationController?.viewControllers.first(where: {
                                $0 is CourseViewController
                            }) else { return }
                            
                            self.navigationController?.popToViewController(controller, animated: true)
                        }
                    }
                    


                        /*query.observeSingleEv ent(of: .value) { (snapshot) in
                    self.database.child("IntraIsil").child("Matriculas").queryOrdered(byChild: "usuario_id").queryStarting(atValue: self.uidUsuer).setValue(objet, forKey: "detalles")*/
                    
                        //.childByAutoId().setValue(objet)
                }))
                alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: {action in
                    print("No acepto")
                }))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

*/



*/
