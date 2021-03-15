//
//  PlacesViewController.swift
//  isilAdmin
//
//  Created by user178963 on 3/11/21.
//

import UIKit
import Firebase

class PlacesViewController: UIViewController{
    
        
    @IBOutlet weak var tableView: UITableView!
    var arrayEnrollment = [EnrollmentBE]()
    var obj: EnrollmentBE!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.cargarTabla()
        /*self.arrayEnrollment.append(EnrollmentBE(id: "1",
                                                 student: "Percy Bobbio",
                                                 career: "Desarrollo de Software",
                                                 course: "Desarollo de IOs",
                                                 date: "01/01/2021",
                                                 schedule: "horario 1"
                                                 ))
                                                 
        
        self.arrayEnrollment.append(EnrollmentBE(
                                                    id: "2",
                                                     student: "Mario Medina",
                                                     career: "Desarrollo de Sistemas",
                                                     course: "Base de datos",
                                                     date: "01/01/2021",
                                                     schedule: "horario 1"
                                                     ))
        
        
        self.arrayEnrollment.append(EnrollmentBE(
                                                    id: "3",
                                                         student: "Mario Medina",
                                                         career: "Marketing",
                                                         course: "Bases de Marketing",
                                                         date: "01/01/2021",
                                                         schedule: "horario 2"
                                                         ))
        
         }*/
        
    }
    
  func cargarTabla(){
    self.database.child("Matriculas").observe(.value, with: { (snapshot) in

        if snapshot.childrenCount > 0 {
            self.arrayEnrollment.removeAll()
            for data in snapshot.children.allObjects as! [DataSnapshot] {
                
                print("data", data)
                let json = data.value as! [String: Any]
                let enroll = EnrollmentBE(id: data.key,
                                          student: json["Alumno"] as! String,
                                          career:  json["Carrera"] as! String)
                

                self.arrayEnrollment.append(enroll)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    
  })
}
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? EnrollmentShowViewController{
            controller.obj = sender as? EnrollmentBE
        }
    }
    
    let arrayAutos = [["Corolla","Yaris","Rav4"],
                        ["R3","SR8","R5"]]
}

extension PlacesViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let brandCar = self.arrayAutos[section]
        //return brandCar.count
        //self.arrayNombres.count
        
        return self.arrayEnrollment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EnrollmentTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EnrollmentTableViewCell
        cell.objPlace = self.arrayEnrollment[indexPath.row]
        
        return cell
    }
}

extension PlacesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objPlace = self.arrayEnrollment[indexPath.row]
        self.performSegue(withIdentifier: "EnrollmentShowViewController", sender: objPlace)
    }
}
