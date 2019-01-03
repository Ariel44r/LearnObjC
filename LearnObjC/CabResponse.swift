//
//  CabResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation
import ObjectMapper

@objc class CabResponse: NSObject, Mappable {
    var codResponse: Int!
    var mensResponse: String!
    
    override init(){ }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        self.codResponse <- map["codResponse"]
        self.mensResponse <- map["mensResponse"]
        
    }
}
