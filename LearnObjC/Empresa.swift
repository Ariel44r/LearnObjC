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
    @objc private var idEmpresa: Int = 0
    @objc private var nEmpresa: String! = nil
    @objc private var error: String? = nil
    @objc private var paises: [Pais] = []
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map["$id"]
        self.idEmpresa <- map["Id_Empresa"]
        self.nEmpresa <- map["NEmpresa"]
        self.error <- map["Error"]
        self.paises <> map["pais"]
        
    }
    
    @objc func getID() -> String { return self.id }
    @objc func getIDEmpresa() -> Int { return self.idEmpresa }
    @objc func getnEmpresa() -> String { return self.nEmpresa }
    @objc func getError() -> String? { return self.error }
    @objc func getPaises() -> [Pais] { return self.paises }
    
}
