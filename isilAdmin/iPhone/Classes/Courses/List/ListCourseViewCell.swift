//
//  ListCourseViewCell.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//

import UIKit

protocol ListCourseViewCellDelegate {
    func ListCourseViewCell(_ cell: ListCourseViewCell, delete obj: CourseBE)
    func ListCourseViewCell(_ cell: ListCourseViewCell, horario obj: CourseBE)
    func ListCourseViewCell(_ cell: ListCourseViewCell, edit obj: CourseBE)
}

class ListCourseViewCell: UITableViewCell{


    @IBOutlet weak var imageCourse: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var career: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var delegate: ListCourseViewCellDelegate?
    
    public var obj: CourseBE!{
        didSet{
            self.updateData()
        }
    }
    
    private func updateData(){
        self.name.text = self.obj.name
        self.code.text = self.obj.code
        self.career.text = self.obj.career
        self.teacher.text = self.obj.teacher
        self.date.text = self.obj.date
        
        let courseHolderImage = UIImage(named: "place_placeholder")
        self.imageCourse.downloadImageInURLString(self.obj.urlImage, placeHolderImage: courseHolderImage) { (image, urlString) in
            if self.obj.urlImage == urlString {
                self.imageCourse.image = image
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.imageCourse.layer.cornerRadius = 30
    }
}


extension ListCourseViewCell{
    
    public var swipeActions: UISwipeActionsConfiguration {
        return UISwipeActionsConfiguration(actions: [self.createDeleteAction(), self.createHorarioAction(), self.createEditAction()])
    }
    
    private func createDeleteAction() -> UIContextualAction {
        
        let action = UIContextualAction(style: .destructive, title: "Eliminar") { (_, _, _) in
            self.delegate?.ListCourseViewCell(self, delete: self.obj)
        }

        action.image = UIImage(systemName: "trash")
        return action
    }
    
    private func createHorarioAction() -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Horario") {(_, _,_) in
            self.delegate?.ListCourseViewCell(self, horario: self.obj)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "calendar")
        return action
    }
    
    private func createEditAction() -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Editar") { (_, _, _) in
            self.delegate?.ListCourseViewCell(self, edit: self.obj)
        }
        
        action.backgroundColor = .systemBlue
        action.image = UIImage(systemName: "square.and.pencil")
        return action
    }
    
}
