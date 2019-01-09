//
//  UnidadNegocio.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/8/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import ObjectMapper

@objc class UnidadNegocio: NSObject, Mappable {
    @objc private var id: String!
    @objc private var idUnidadNegocio: Int = 0
    @objc private var nUnidadNegocio: String!
    @objc private var icono: String!
    @objc private var macroProceso: [Any] = []
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        self.id <- map["$id"]
        self.idUnidadNegocio <- map["Id_UnidadNegocio"]
        self.nUnidadNegocio <- map["NUnidadNegocio"]
        self.icono <- map["IconoUN"]
        self.macroProceso <- map["MacroProceso"]
        
    }
}
