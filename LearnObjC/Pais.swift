//
//  Pais.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/8/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import ObjectMapper

@objc class Pais: NSObject, Mappable {
    @objc private var id: String!
    @objc private var idPais: Int = 0
    @objc private var nPais: String!
    @objc private var unidadesNegocio: [UnidadNegocio] = []
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        self.id <- map["$id"]
        self.idPais <- map["Id_Pais"]
        self.nPais <- map["NPais"]
        self.unidadesNegocio <- map["UnidadNegocio"]
        
    }
    
    @objc func getNPais() -> String { return self.nPais }
    @objc func getID() -> String { return self.id }
    @objc func getnPais() -> String { return self.nPais }
    @objc func getUnidadesNegocio() -> [UnidadNegocio] { return self.unidadesNegocio }
    
}
