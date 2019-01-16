//
//  MacroProceso.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/8/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import ObjectMapper

@objc class MacroProceso: BaseMap {
    @objc private var id: String!
    @objc private var idMacroProceso: Int = 0
    @objc private var nMacroProceso: String!
    @objc private var iconoMP: String!
    @objc private var procesos: [Any] = []
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map["$id"]
        self.idMacroProceso <- map["Id_Macroproceso"]
        self.nMacroProceso <- map["NMacroProceso"]
        self.iconoMP <- map["IconoMP"]
        
        
    }
    
    @objc func getID() -> String { return self.id }
    @objc func getIDMacroProceso() -> Int { return self.idMacroProceso }
    @objc func getNMacroProceso() -> String { return self.nMacroProceso }
    @objc func getIcono() -> String { return self.iconoMP }
    @objc func getProcesos() -> [Any] { return self.procesos }
    
}
