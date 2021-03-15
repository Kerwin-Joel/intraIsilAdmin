//
//  EnrollmentTableViewCell.swift
//  isilAdmin
//
//  Created by user178963 on 3/12/21.
//

import UIKit

class EnrollmentTableViewCell: UITableViewCell {
    @IBOutlet weak private var lblStudent      : UILabel!
    @IBOutlet weak private var lblCareer   : UILabel!
    @IBOutlet weak private var lblCourse   : UILabel!
    @IBOutlet weak private var lblDate   : UILabel!
    @IBOutlet weak private var lblSchedule   : UILabel!
  
    
    //var delegate : EnrollmentTableViewCellDelegate?
    
    public var objPlace: EnrollmentBE!{
        didSet{
            self.updateData()
        }
    }
    
    private func updateData(){
        self.lblStudent.text = self.objPlace.place_Student
        self.lblCareer.text = self.objPlace.place_Career
        /*self.lblCourse.text = self.objPlace.place_Course
        self.lblDate.text = self.objPlace.place_date
        self.lblSchedule.text = self.objPlace.place_schedule*/
        
    }
    
    /*override func draw(_ rect: CGRect) {
        self.lblImage.layer.cornerRadius = 30
    }*/

}
