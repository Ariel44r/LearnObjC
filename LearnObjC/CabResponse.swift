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
    @objc var codResponse: Int = 0
    @objc var mensResponse: String! = nil
    
    override init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        self.codResponse <- map["codResponse"]
        self.mensResponse <- map["mensResponse"]
        
    }
}
