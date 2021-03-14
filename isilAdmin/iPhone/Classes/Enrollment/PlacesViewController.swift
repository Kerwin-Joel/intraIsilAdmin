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
        /*self.arrayEnrollment.append(EnrollmentBE(id: "1", name: "Isil Miraflores",)
                                                 
        
        self.arrayEnrollment.append(EnrollmentBE(id: "2", name: "Isil San Isidro"))
        
        self.arrayEnrollment.append(EnrollmentBE(id: "3", name: "Isil La Molina"))*/
    }
    
  func cargarTabla(){
    self.database.child("Matriculas").observe(.value, with: { (snapshot) in

        if snapshot.childrenCount > 0 {
            self.arrayEnrollment.removeAll()
            for data in snapshot.children.allObjects as! [DataSnapshot] {
                
                print("data", data)
                let json = data.value as! [String: Any]
                let enroll = EnrollmentBE(id: data.key,
                                          name: json["acepto_reglamento"] as! String,
                                          address: json["horario1"] as! String)
                

                self.arrayEnrollment.append(enroll)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    
  })
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? EnrollmentMoreViewController{
            controller.objPlace = sender as? EnrollmentBE
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
        
        
        let r = CGFloat.random(in: 0...255)/255
        let g = CGFloat.random(in: 0...255)/255
        let b = CGFloat.random(in: 0...255)/255
        let color = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1)
        cell.backgroundColor = color
        
        return cell
    }
}

extension PlacesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objPlace = self.arrayEnrollment[indexPath.row]
        self.performSegue(withIdentifier: "EnrollmentMoreViewController", sender: objPlace)
    }
}
