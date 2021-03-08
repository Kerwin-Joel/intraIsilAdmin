//
//  ListCoursesViewController.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//

import Foundation
import UIKit
import Firebase

class ListCoursesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrayCourses = [CourseBE]()
    var obj: CourseBE!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.cargarTabla()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Nuevo", style: .done, target: self, action: #selector(self.goAdd))
    }
    
    @objc func goAdd(sender: AnyObject) {
        self.performSegue(withIdentifier: "AddCourseViewController", sender: nil)
    }
    
    func cargarTabla(){
        
        self.database.child("Cursos").observe(.value, with: { (snapshot) in

            if snapshot.childrenCount > 0 {
                self.arrayCourses.removeAll()
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let json = data.value as! [String: Any]
                    let course = CourseBE(id: data.key,
                                          name: json["nombre"] as! String,
                                          teacher: json["profesor"] as! String,
                                          urlImage: json["urlImage"] as! String,
                                          date: json["fecha"] as! String,
                                          code: json["codigo"] as! String,
                                          career: json["carrera"] as! String)

                    self.arrayCourses.append(course)
                 
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        })
        
    }
    
}

extension ListCoursesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.obj = self.arrayCourses[indexPath.row]
        self.performSegue(withIdentifier: "FormCoursesViewController", sender: self.obj)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath) as? ListCourseViewCell
        return cell?.swipeActions
    }
}

extension ListCoursesViewController: ListCourseViewCellDelegate{

    func ListCourseViewCell(_ cell: ListCourseViewCell, delete obj: CourseBE) {

        let alert = UIAlertController(title: "¡Alerta!", message: "¿Desea eliminar el curso \(obj.name)?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Si, eliminarlo", style: UIAlertAction.Style.default, handler: {action in
            
            guard let indexPath = self.tableView.indexPath(for: cell) else { return }
            self.arrayCourses.remove(at: indexPath.row)
            
            self.tableView.performBatchUpdates {
                self.tableView.deleteRows(at: [indexPath], with: .right)
            } completion: { (_) in
                self.database.child("Cursos/\(obj.id)").removeValue{ error, ele  in
                    if error != nil {
                        print("error \(String(describing: error))")
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    func ListCourseViewCell(_ cell:ListCourseViewCell, horario obj: CourseBE) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        self.obj = self.arrayCourses[indexPath.row]
        self.performSegue(withIdentifier: "AddScheduleViewController", sender: self.obj)
    }
    
    func ListCourseViewCell(_ cell: ListCourseViewCell, edit obj: CourseBE) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        self.obj = self.arrayCourses[indexPath.row]
        self.performSegue(withIdentifier: "FormCoursesViewController", sender: self.obj)
    }
    
    
}

extension ListCoursesViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCourses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellIdentifier = "ListCourseViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListCourseViewCell
        cell.delegate = self
        cell.obj = self.arrayCourses[indexPath.row]
        
        return cell
    }
}

extension ListCoursesViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FormCoursesViewController" {
            if let destino = segue.destination as? FormCoursesViewController{
                destino.obj = self.obj
            }
        } else if segue.identifier == "AddScheduleViewController" {
            if let destino = segue.destination as? AddScheduleViewController{
                destino.obj = self.obj
            }
        }
    }
}

