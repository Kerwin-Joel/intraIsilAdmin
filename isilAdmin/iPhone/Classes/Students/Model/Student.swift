//
//  Student.swift
//  isilAdmin
//
//  Created by kerwin Joel on 3/3/21.
//

import Foundation

class Student {
    var key : String
    var dni : String
    var alumno : String
    var apellido : String
    var nacimiento :String
    var carrera : String
    
    
    init(dictionary:[String: AnyObject], key : String) {
        self.key = key
        self.dni = dictionary["dni"] as! String
        self.alumno = dictionary["alumno"] as! String
        self.apellido = dictionary["apellido"] as! String
        self.carrera = dictionary["carrera"] as! String
        self.nacimiento = dictionary["nacimiento"] as! String
        
    }
}
