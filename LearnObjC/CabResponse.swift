//
//  CabResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class CabResponse: BaseMap {
    @objc var codResponse: Int = 0
    @objc var mensResponse: String! = nil
    
    required init() { }
    override func map(map: JSON) {
        self.codResponse <- map["codResponse"]
        self.mensResponse <- map["mensResponse"]
        
    }
}
