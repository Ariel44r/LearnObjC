//
//  ListadoResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/21/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class ListadoResponse: BaseMap {
    @objc var cabResponse: CabResponse = CabResponse()
    @objc var documentos: [Documento] = []
    
    required init() { }
    override func map(map: JSON) {
        self.cabResponse <- map["cabResponse"]
        self.documentos <> map["responseSocio"]
        
    }
}
