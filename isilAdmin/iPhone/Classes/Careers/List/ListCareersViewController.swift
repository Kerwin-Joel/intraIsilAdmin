//
//  ListCareersViewController.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//

import Foundation
import UIKit
import Firebase

class ListCareersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrayCareers = [CareersBE]()
    var obj: CareersBE!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.cargarTabla()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Nuevo", style: .done, target: self, action: #selector(self.showForm))
    }
    
    @objc func showForm(sender: AnyObject) {
        self.obj = nil
        self.performSegue(withIdentifier: "FormCareersViewController", sender: nil)
    }
    
    func cargarTabla(){
        
        self.database.child("Carreras").observe(.value, with: { (snapshot) in

            if snapshot.childrenCount > 0 {
                self.arrayCareers.removeAll()
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let json = data.value as! [String: Any]
                    let career = CareersBE(id: data.key, name: json["nombre"] as! String, faculty: json["facultad"] as! String)

                    self.arrayCareers.append(career)
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        })
        
    }
    
}

extension ListCareersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.obj = self.arrayCareers[indexPath.row]
        self.performSegue(withIdentifier: "FormCareersViewController", sender: self.obj)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath) as? ListCareersViewCell
        return cell?.swipeActions
    }
}

extension ListCareersViewController: ListCareersViewCellDelegate{
    func ListCareersViewCell(_ cell: ListCareersViewCell, delete obj: CareersBE) {

        let alert = UIAlertController(title: "¡Alerta!", message: "¿Desea eliminar la sede \(obj.name)?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Si, eliminarlo", style: UIAlertAction.Style.default, handler: {action in
            
            guard let indexPath = self.tableView.indexPath(for: cell) else { return }
            self.arrayCareers.remove(at: indexPath.row)
            
            self.tableView.performBatchUpdates {
                self.tableView.deleteRows(at: [indexPath], with: .right)
            } completion: { (_) in
                self.database.child("Carreras/\(obj.id)").removeValue{ error, ele  in
                    if error != nil {
                        print("error \(String(describing: error))")
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func ListCareersViewCell(_ cell: ListCareersViewCell, edit obj: CareersBE) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        self.obj = self.arrayCareers[indexPath.row]
        self.performSegue(withIdentifier: "FormCareersViewController", sender: self.obj)
    }
    
    
}

extension ListCareersViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCareers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellIdentifier = "ListCareersViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListCareersViewCell
        cell.delegate = self
        cell.obj = self.arrayCareers[indexPath.row]
        
        return cell
    }
}

extension ListCareersViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FormCareersViewController"{
            if let destino = segue.destination as? FormCareersViewController{
                destino.obj = self.obj
            }
        }
    }
}
