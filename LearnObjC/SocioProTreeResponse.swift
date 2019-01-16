//
//  SocioProTreeResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/3/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class SocioProTreeResponse: BaseMap {
    @objc var cabResponse: CabResponse = CabResponse()
    @objc var empresas: [Empresa] = []
    
    required init() { }
    override func map(map: JSON) {
        self.cabResponse <- map["cabResponse"]
        self.empresas <> map["responseSocio"]
        
    }
    
}
