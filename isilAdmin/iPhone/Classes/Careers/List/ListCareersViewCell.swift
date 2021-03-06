//
//  ListTableViewCell.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//

import UIKit

protocol ListCareersViewCellDelegate {
    func ListCareersViewCell(_ cell: ListCareersViewCell, delete obj: CareersBE)
    func ListCareersViewCell(_ cell: ListCareersViewCell, edit obj: CareersBE)
}

class ListCareersViewCell: UITableViewCell{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var faculty: UILabel!
    
    var delegate: ListCareersViewCellDelegate?
    
    public var obj: CareersBE!{
        didSet{
            self.updateData()
        }
    }
    
    private func updateData(){
        self.name.text = self.obj.name
        self.faculty.text = self.obj.faculty
    }
    
}

extension ListCareersViewCell{
    
    public var swipeActions: UISwipeActionsConfiguration {
        return UISwipeActionsConfiguration(actions: [self.createDeleteAction(), self.createEditAction()])
    }
    
    private func createDeleteAction() -> UIContextualAction {
        
        let action = UIContextualAction(style: .destructive, title: "Eliminar") { (_, _, _) in
            self.delegate?.ListCareersViewCell(self, delete: self.obj)
        }

        action.image = UIImage(systemName: "trash")
        return action
    }
    
    private func createEditAction() -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Editar") { (_, _, _) in
            self.delegate?.ListCareersViewCell(self, edit: self.obj)
        }
        
        action.backgroundColor = .systemBlue
        action.image = UIImage(systemName: "square.and.pencil")
        return action
    }
    
}
