//
//  Documento.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/21/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class Documento: BaseMap {
    @objc var id: String!
    @objc var idDocumento: Int = -1
    @objc var titulo: String!
    @objc var vigente: String!
    @objc var error: String?
    
    required init() { }
    override func map(map: JSON) {
        self.id <- map["$id"]
        self.idDocumento <- map["Id_Documento"]
        self.titulo <- map["Titulo"]
        self.vigente <- map["Vigente"]
        self.error <- map["Error"]
        
    }
}
