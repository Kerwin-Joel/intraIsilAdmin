//
//  CourseBE.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//

import Foundation
import UIKit

class CourseBE{
    
    var id: String
    var name: String
    var teacher: String
    var urlImage: String
    var date: String
    
    init(id: String, name: String, teacher: String, urlImage: String, date: String) {
        self.id = id
        self.name = name
        self.teacher = teacher
        self.urlImage = urlImage
        self.date = date
    }
}
