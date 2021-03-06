//
//  ListVenuesViewController.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//

import Foundation
import UIKit
import Firebase

class ListVenuesViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayVenues = [CampusBE]()
    var obj: CampusBE!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.cargarTabla()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Nuevo", style: .done, target: self, action: #selector(self.showForm))
    }
    
    @objc func showForm(sender: AnyObject) {
        self.obj = nil
        self.performSegue(withIdentifier: "FormVenuesViewController", sender: nil)
    }
    
    
    
    
    func cargarTabla(){
        
        self.database.child("Sedes").observe(.value, with: { (snapshot) in

            if snapshot.childrenCount > 0 {
                self.arrayVenues.removeAll()
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    print("data", data)
                    let json = data.value as! [String: Any]
                    let course = CampusBE(nombre: json["nombre"] as! String, id: data.key)

                    self.arrayVenues.append(course)
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        })
        
    }
    
}

extension ListVenuesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.obj = self.arrayVenues[indexPath.row]
        self.performSegue(withIdentifier: "FormVenuesViewController", sender: self.obj)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath) as? ListVenuesViewCell
        return cell?.swipeActions
    }
}
extension ListVenuesViewController: ListVenuesViewCellDelegate{
    func ListVenuesViewCell(_ cell: ListVenuesViewCell, delete obj: CampusBE) {
        print("delete delete delete delete ")
        let alert = UIAlertController(title: "¡Alerta!", message: "¿Desea eliminar la sede \(obj.nombre)?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Si, eliminarlo", style: UIAlertAction.Style.default, handler: {action in
            
            guard let indexPath = self.tableView.indexPath(for: cell) else { return }
            self.arrayVenues.remove(at: indexPath.row)
            
            self.tableView.performBatchUpdates {
                self.tableView.deleteRows(at: [indexPath], with: .right)
            } completion: { (_) in
                self.database.child("Sedes/\(obj.id)").removeValue{ error, ele  in
                    if error != nil {
                        print("error \(String(describing: error))")
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func ListVenuesViewCell(_ cell: ListVenuesViewCell, edit obj: CampusBE) {
        print("edit edit edit edit ")
        
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        self.obj = self.arrayVenues[indexPath.row]
        self.performSegue(withIdentifier: "FormVenuesViewController", sender: self.obj)
    }
    
    
}

extension ListVenuesViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayVenues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellIdentifier = "ListVenuesViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListVenuesViewCell
        cell.delegate = self
        cell.obj = self.arrayVenues[indexPath.row]
        
        return cell
    }
    
}

extension ListVenuesViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue === > ", segue)
        if segue.identifier == "FormVenuesViewController"{
            if let destino = segue.destination as? FormVenuesViewController{
                destino.obj = self.obj
            }
        }
    }
}
