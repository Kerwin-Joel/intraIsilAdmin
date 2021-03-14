//
//  EnrollmentBE.swift
//  isilAdmin
//
//  Created by user178963 on 3/12/21.
//

import Foundation
import UIKit

class EnrollmentBE{
    var id              : String
    var place_Name      : String
    var place_Address   : String
    /*var place_URLImage  : String*/
    
    init(id: String, name: String, address: String/*, Image: String*/) {
        self.id = id
        self.place_Name = name
        self.place_Address = address
        /*self.place_URLImage = Image*/
    }
}
