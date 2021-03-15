//
//  DetailsBE.swift
//  isilAdmin
//
//  Created by user178488 on 3/15/21.
//

import Foundation

typealias JSON = [String: Any]

class DetailsBE{
    
    var idDetails       : String
    var date           : String
    var schedule       : String
    
    init(json: JSON, idDetail: String) {
        
        self.idDetails = idDetail//json["idSchedule"] as? String ?? ""
        self.date        = json["fecha"] as? String ?? ""
        self.schedule    = json["horario"] as? String ?? ""
    }
}
