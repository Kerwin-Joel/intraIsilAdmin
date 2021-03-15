//
//  EnrollmentBE.swift
//  isilAdmin
//
//  Created by user178963 on 3/12/21.
//

import Foundation
import UIKit

class EnrollmentBE{
    var id                  : String
    var place_Student       : String
    var place_Career        : String
    var place_Course        : String
    var place_date          : String
    var place_schedule      : String

    init(id: String, student: String, career: String, course: String, date: String, schedule: String) {
        self.id = id
        self.place_Student = student
        self.place_Career = career
        self.place_Course = course
        self.place_date = date
        self.place_schedule = schedule
    }
    
    
}
