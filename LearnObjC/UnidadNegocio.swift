//
//  UnidadNegocio.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/8/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class UnidadNegocio: BaseMap {
    @objc private var id: String!
    @objc private var idUnidadNegocio: Int = 0
    @objc private var nUnidadNegocio: String!
    @objc private var icono: String!
    @objc private var macroProceso: [MacroProceso] = []
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map["$id"]
        self.idUnidadNegocio <- map["Id_UnidadNegocio"]
        self.nUnidadNegocio <- map["NUnidadNegocio"]
        self.icono <- map["IconoUN"]
        self.macroProceso <> map["MacroProceso"]
        
    }
    
    @objc func getID() -> String { return self.id }
    @objc func getIDUnidadNegocio() -> Int { return self.idUnidadNegocio }
    @objc func getnUnidadNegocio() -> String { return self.nUnidadNegocio }
    @objc func getIcono() -> String { return self.icono }
    @objc func getMacroProcesos() -> [MacroProceso] { return self.macroProceso }
    
}
