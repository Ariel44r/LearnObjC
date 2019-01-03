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
    var cabResponse: CabResponse!
    var responseSocio: String!
    
    override init() {}

    required init?(map: Map) { }
    
    func mapping(map: Map) {
        self.cabResponse <- map["cabResponse"]
        self.responseSocio <- map["responseSocio"]
        
    }
    
}
