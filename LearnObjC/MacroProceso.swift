//
//  MacroProceso.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/8/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class MacroProceso: BaseMap {
    @objc private var id: String!
    @objc private var idMacroProceso: Int = -1
    @objc private var nMacroProceso: String!
    @objc private var iconoMP: String!
    @objc private var procesos: [Proceso] = []
    
    enum Keys: String, CodingKey {
        case id = "$id"
        case idMacroProceso = "Id_Macroproceso"
        case nMacroProceso = "NMacroProceso"
        case iconoMP = "IconoMP"
        case procesos = "Proceso"
        
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(id, forKey: .id)
        try container.encode(idMacroProceso, forKey: .idMacroProceso)
        try container.encode(nMacroProceso, forKey: .nMacroProceso)
        try container.encode(iconoMP, forKey: .iconoMP)
        try container.encode(procesos, forKey: .procesos)
        
    }
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map["$id"]
        self.idMacroProceso <- map["Id_Macroproceso"]
        self.nMacroProceso <- map["NMacroProceso"]
        self.iconoMP <- map["IconoMP"]
        self.procesos <> map["Proceso"]
        
        
    }
    
    @objc func getID() -> String { return self.id }
    @objc func getIDMacroProceso() -> Int { return self.idMacroProceso }
    @objc func getNMacroProceso() -> String { return self.nMacroProceso }
    @objc func getIcono() -> String { return self.iconoMP }
    @objc func getProcesos() -> [Any] { return self.procesos }
    
}
