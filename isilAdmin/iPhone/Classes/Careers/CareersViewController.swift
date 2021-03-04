//
//  CareersViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 2/23/21.
//

import UIKit
import Foundation
import Firebase

class CareersViewController: UIViewController, UITableViewDelegate

{
    
    @IBOutlet weak var tblCareer: UITableView!
    var careersList = [CareerBE]()
    var obj: CareerBE!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tblCareer.delegate = self
        self.tblCareer.dataSource = self
        self.loadData()
        
    }
    
    func loadData(){
        
    self.database.child("Carreras").child("Ingenieria").observe(DataEventType.value, with: {(snapshot) in
            print("snapshot", snapshot)
            if snapshot.childrenCount > 0 {
                self.careersList.removeAll()

                for career in snapshot.children.allObjects as! [DataSnapshot] {
                    
                     
                    let careerObject = career.value as? [String: AnyObject]
                    
                    let name  = careerObject?["nombre"] as! String
                    let description  = careerObject?["descripcion"] as! String
                    let career = CareerBE(name: name, description: description)
                    
                    
                    self.careersList.append(career)
                }

                DispatchQueue.main.async {
                    self.tblCareer.reloadData()
                }
                //self.tableCourses.reloadData()
            }
            
        })
   }

}

extension CareersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.careersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("no te quiere")
          
        let cellIdentifier = "celCareer"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CareerTableViewCell
        cell.obj = self.careersList[indexPath.row]
        
        return cell
        
    }
    
    
}

