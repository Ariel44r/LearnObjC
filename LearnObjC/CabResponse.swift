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
    @objc var codResponse: Int
    @objc var mensResponse: String
    
    override init(){
        self.codResponse = 0
        self.mensResponse = ""
        
    }
    
    required init?(map: Map) {
        self.codResponse = 0
        self.mensResponse = ""
        
    }
    
    func mapping(map: Map) {
        self.codResponse <- map["codResponse"]
        self.mensResponse <- map["mensResponse"]
        
    }
}
