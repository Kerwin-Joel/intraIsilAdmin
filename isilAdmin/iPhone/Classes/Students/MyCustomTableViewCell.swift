//
//  MyCustomTableViewCell.swift
//  isilAdmin
//
//  Created by kerwin Joel on 3/3/21.
//

import UIKit

protocol MyCustomCellDelegator {
    func callSegueFromCell(myData dataobject: String)
}

class MyCustomTableViewCell: UITableViewCell {
    
    var delegate:MyCustomCellDelegator!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelId: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func update(_ sender: AnyObject) {

        if(self.delegate != nil){ //Just to be safe.
            self.delegate.callSegueFromCell(myData: "\(labelId.text ?? "")")
        }
       
    }
    
}
