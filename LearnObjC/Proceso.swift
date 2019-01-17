//
//  Proceso.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/16/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class Proceso: BaseMap {
    private var id: String!
    private var idProceso: Int = -1
    private var nProceso: String!
    private var iconoProceso: String!
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map["$id"]
        self.idProceso <- map["Id_Proceso"]
        self.nProceso <- map["NProceso"]
        self.iconoProceso <- map["IconoProceso"]
        
    }
}
