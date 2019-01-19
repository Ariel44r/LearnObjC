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
    private var idProceso: Int! = nil
    private var nProceso: String!
    private var iconoProceso: String!
    
    enum Keys: String, CodingKey {
        case id = "$id"
        case idProceso = "Id_Proceso"
        case nProceso = "NProceso"
        case iconoProceso = "IconoProceso"
        
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(id, forKey: .id)
        try container.encode(idProceso, forKey: .idProceso)
        try container.encode(nProceso, forKey: .nProceso)
        try container.encode(iconoProceso, forKey: .iconoProceso)
        
    }
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map["$id"]
        self.idProceso <- map["Id_Proceso"]
        self.nProceso <- map["NProceso"]
        self.iconoProceso <- map["IconoProceso"]
        
    }
}
