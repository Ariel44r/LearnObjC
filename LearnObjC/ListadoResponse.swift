//
//  ListadoResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/21/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class ListadoResponse: BaseResponse {
    @objc var documentos: [Documento] = []
    
    required init() { }
    override func map(map: JSON) {
        super.map(map: map)
        self.documentos <> map["responseSocio"]
        
    }
}
