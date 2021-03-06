//
//  ListTableViewCell.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//

import UIKit

protocol ListVenuesViewCellDelegate {
    func ListVenuesViewCell(_ cell: ListVenuesViewCell, delete obj: CampusBE)
    func ListVenuesViewCell(_ cell: ListVenuesViewCell, edit obj: CampusBE)
}

class ListVenuesViewCell: UITableViewCell{
    
    @IBOutlet weak var nombre: UILabel!
    
    var delegate: ListVenuesViewCellDelegate?
    
    public var obj: CampusBE!{
        didSet{
            self.updateData()
        }
    }
    
    
    private func updateData(){
        self.nombre.text = self.obj.nombre
    }
    
}


extension ListVenuesViewCell{
    
    public var swipeActions: UISwipeActionsConfiguration {
        return UISwipeActionsConfiguration(actions: [self.createDeleteAction(), self.createEditAction()])
    }
    
    private func createDeleteAction() -> UIContextualAction {
        
        let action = UIContextualAction(style: .destructive, title: "Eliminar") { (_, _, _) in
            self.delegate?.ListVenuesViewCell(self, delete: self.obj)
        }

        action.image = UIImage(systemName: "trash")
        return action
    }
    
    private func createEditAction() -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Editar") { (_, _, _) in
            self.delegate?.ListVenuesViewCell(self, edit: self.obj)
        }
        
        action.backgroundColor = .systemBlue
        action.image = UIImage(systemName: "square.and.pencil")
        return action
    }
    
}
