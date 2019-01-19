//
//  Empresa.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/4/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class Empresa: BaseMap {
    @objc private var id: String! = nil
    @objc private var idEmpresa: Int = -1
    @objc private var nEmpresa: String! = nil
    @objc private var error: String? = nil
    @objc private var paises: [Pais] = []
    
    enum Keys: String, CodingKey {
        case id = "$id"
        case idEmpresa = "Id_Empresa"
        case nEmpresa = "NEmpresa"
        case error = "Error"
        case paises = "pais"
        
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(id, forKey: .id)
        try container.encode(idEmpresa, forKey: .idEmpresa)
        try container.encode(nEmpresa, forKey: .nEmpresa)
        try container.encode(error, forKey: .error)
        try container.encode(paises, forKey: .paises)
        
    }
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map[Keys.id.rawValue]
        self.idEmpresa <- map[Keys.idEmpresa.rawValue]
        self.nEmpresa <- map[Keys.nEmpresa.rawValue]
        self.error <- map[Keys.nEmpresa.rawValue]
        self.paises <> map[Keys.paises.rawValue]
        
    }
    
    @objc func getID() -> String { return self.id }
    @objc func getIDEmpresa() -> Int { return self.idEmpresa }
    @objc func getnEmpresa() -> String { return self.nEmpresa }
    @objc func getError() -> String? { return self.error }
    @objc func getPaises() -> [Pais] { return self.paises }
    
}
