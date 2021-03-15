//
//  EnrollmenShowViewCell.swift
//  isilAdmin
//
//  Created by user178488 on 3/15/21.
//

import UIKit

class EnrollmentShowViewCell: UITableViewCell {
   @IBOutlet weak private var lblCourse   : UILabel!
    @IBOutlet weak private var lblDate   : UILabel!
    @IBOutlet weak private var lblSchedule   : UILabel!
  
    
    //var delegate : EnrollmentTableViewCellDelegate?
    
    public var obj: EnrollmentBE!{
        didSet{
            self.updateData()
        }
    }
    
    private func updateData(){
        /*self.lblCourse.text = self.obj.place_Course
        self.lblDate.text = self.obj.place_date
        self.lblSchedule.text = self.obj.place_schedule
        */
    }
    
}
