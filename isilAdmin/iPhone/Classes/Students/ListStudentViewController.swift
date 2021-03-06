//
//  ListStudentViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 3/3/21.
//

import UIKit
import Firebase
class ListStudentViewController: UIViewController, UITableViewDelegate, MyCustomCellDelegator {
    
    @IBOutlet weak var tableView: UITableView!
    
    var alumnos :[Student] = [Student]()
    var user    :String?
    

    override func viewDidLoad() {

        tableView.dataSource    = self
        tableView.delegate      = self
        alumnos                 = [Student]()
        
        
        self.database.child("alumnos").observe(.value, with:{ snapshot in
            let dicRot = snapshot.value as? [String : AnyObject] ?? [:]
            for key in Array(dicRot.keys){
                self.alumnos.append(Student(dictionary: dicRot[key] as! [String:AnyObject] , key: key))
            }
            
            print(dicRot)
            self.tableView.reloadData()
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "update"{
            let vc:UpdateStudentViewController = segue.destination as! UpdateStudentViewController
            vc.id = "\(user ?? "")"
        }
        print("segnudo")
    }
    
    func callSegueFromCell(myData dataobject: String) {
        user = dataobject
        self.performSegue(withIdentifier: "update", sender:dataobject )
    }
 
}


extension ListStudentViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alumnos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let eachAlumno      = alumnos[indexPath.row]
        let cell            = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! MyCustomTableViewCell
        
        cell.delegate       = self
        cell.label.text     = "\(eachAlumno.alumno)"
        cell.labelId.text   = "\(eachAlumno.dni)"
        
        print("primero")
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
