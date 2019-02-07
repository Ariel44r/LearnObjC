//
//  CabResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class BaseResponse: BaseMap {
    @objc var cabResponse: CabResponse = CabResponse()
    
    override func map(map: JSON) {
        self.cabResponse <- map["cabResponse"]
        
    }
}

@objc class CabResponse: BaseMap {
    @objc var codResponse: Int = -1
    @objc var mensResponse: String! = nil
    
    enum Keys: String, CodingKey {
        case codResponse = "codResponse"
        case mensResponse = "mensResponse"
        
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(codResponse, forKey: .codResponse)
        try container.encode(mensResponse, forKey: .mensResponse)
        
    }
    
    required init() { }
    override func map(map: JSON) {
        self.codResponse <- map[Keys.codResponse.rawValue]
        self.mensResponse <- map[Keys.mensResponse.rawValue]
        
    }
}
