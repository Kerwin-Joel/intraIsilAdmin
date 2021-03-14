//
//  EnrollmentTableViewCell.swift
//  isilAdmin
//
//  Created by user178963 on 3/12/21.
//

import UIKit

class EnrollmentTableViewCell: UITableViewCell {
    @IBOutlet weak private var lblName      : UILabel!
    @IBOutlet weak private var lblAddress   : UILabel!
    @IBOutlet weak private var lblImage     : UIImageView!
    
    //var delegate : EnrollmentTableViewCellDelegate?
    
    public var objPlace: EnrollmentBE!{
        didSet{
            self.updateData()
        }
    }
    
    private func updateData(){
        self.lblName.text = self.objPlace.place_Name
        self.lblAddress.text = self.objPlace.place_Address
        
    }
    
    override func draw(_ rect: CGRect) {
        self.lblImage.layer.cornerRadius = 30
    }

}
