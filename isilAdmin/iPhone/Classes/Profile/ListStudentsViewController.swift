//
//  ListStudentsViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 3/2/21.
//

import UIKit
import Firebase




class ListStudentsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let data = ["first","second","tercero"]
    
    
    var postDict:[String : String] = [:]
    var numberUser = 1      //descomentar
    

    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        
        
        
        
        
        
    //descomentar
        
        super.viewDidLoad()
//
//
//        alumno.getData { (error, DataSnapshot) in
//            self.numberUser = Int(DataSnapshot.childrenCount)
//            if error == nil{
//                for i in 0..<(self.numberUser) {
//                    alumno.child("user-\(i)").observe(DataEventType.value, with: { (snapshot) in
//                        self.postDict = snapshot.value as? [String : String] ?? [:]
////                        print(self.postDict)
////                        print("item recorrido \(i)")
//                      })
//                }
//            }
//        }
   //descomentar
        
    }
    
    
     

}

extension ListStudentsViewController: UITableViewDelegate{
    
}

extension ListStudentsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        ///
//        let alumno = self.database.child("alumnos")
//        var arr = [String]()
//        var datas = ["da","sa","sa"]
//        alumno.getData { (error, DataSnapshot) in
//            self.numberUser = Int(DataSnapshot.childrenCount)
//            if error == nil{
//
//                for i in 0..<(self.numberUser) {
//                    alumno.child("user-\(i)").observe(DataEventType.value, with: { (snapshot) in
//                        self.postDict = snapshot.value as? [String : String] ?? [:]
////                        print(self.postDict)
////                        print("item recorrido \(i)")
//                        for (key, value) in self.postDict {
//                            if key == "dni" {
//                                arr.append(value)
//                            }
//                        }
//                        cell.textLabel?.text = arr[indexPath.row]
//
//                        print(arr)
//                      })
//
//                }
//
//            }
//
//        }
        
        cell.textLabel?.text = "das"
        
        
        return cell
    }
    
    
}
