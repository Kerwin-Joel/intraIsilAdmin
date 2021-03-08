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
    var career: String
    var code: String
    
    init(id: String, name: String, teacher: String, urlImage: String, date: String, code:String, career:String) {
        self.id = id
        self.name = name
        self.teacher = teacher
        self.urlImage = urlImage
        self.date = date
        self.career = career
        self.code = code
    }
}
