//
//  CampusBE.swift
//  isilAdmin
//
//  Created by Stalin Huallullo on 5/03/21.
//

import Foundation
import UIKit

class CampusBE {
    var id      : String
    var nombre  : String
    
    
    init(nombre: String, id: String) {
        
        self.id = id
        self.nombre = nombre
        //self.nombre        = json["nombre"] as? String ?? ""
    }
    
}
