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
    
    enum Keys: String, CodingKey {
        case id = "$id"
        case idPais = "Id_Pais"
        case nPais = "NPais"
        case unidadesNegocio = "UnidadNegocio"
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(id, forKey: .id)
        try container.encode(idPais, forKey: .idPais)
        try container.encode(nPais, forKey: .nPais)
        try container.encode(unidadesNegocio, forKey: .unidadesNegocio)
        
    }
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map[Keys.id.rawValue]
        self.idPais <- map[Keys.idPais.rawValue]
        self.nPais <- map[Keys.nPais.rawValue]
        self.unidadesNegocio <> map[Keys.unidadesNegocio.rawValue]
        
    }
    
    @objc func getNPais() -> String { return self.nPais }
    @objc func getID() -> String { return self.id }
    @objc func getnPais() -> String { return self.nPais }
    @objc func getUnidadesNegocio() -> [UnidadNegocio] { return self.unidadesNegocio }
    
}
