//
//  SocioProTreeResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/3/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation
import ObjectMapper

@objc class SocioProTreeResponse: NSObject, Mappable {
    @objc var cabResponse: CabResponse
    @objc var responseSocio: String
    
    override init() {
        self.cabResponse = CabResponse()
        self.responseSocio = ""
        
    }

    required init?(map: Map) {
        self.cabResponse = CabResponse()
        self.responseSocio = ""
        
    }
    
    func mapping(map: Map) {
        self.cabResponse <- map["cabResponse"]
        self.responseSocio <- map["responseSocio"]
        
    }
    
    @objc func getResponseSocio() -> String {
        return self.responseSocio
        
    }
    
}
