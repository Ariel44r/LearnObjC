//
//  Pais.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/8/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class Pais: BaseMap {
    @objc private var id: String!
    @objc private var idPais: Int = -1
    @objc private var nPais: String!
    @objc private var unidadesNegocio: [UnidadNegocio] = []
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map["$id"]
        self.idPais <- map["Id_Pais"]
        self.nPais <- map["NPais"]
        self.unidadesNegocio <> map["UnidadNegocio"]
        
    }
    
    @objc func getNPais() -> String { return self.nPais }
    @objc func getID() -> String { return self.id }
    @objc func getnPais() -> String { return self.nPais }
    @objc func getUnidadesNegocio() -> [UnidadNegocio] { return self.unidadesNegocio }
    
}
