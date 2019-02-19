//
//  SocioProTreeResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/3/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class SocioProTreeResponse: BaseResponse {
    @objc var empresas: [Empresa] = []
    
    enum Keys: String, CodingKey {
        case cabResponse = "cabResponse"
        case empresas = "responseSocio"
        
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(cabResponse, forKey: .cabResponse)
        try container.encode(empresas, forKey: .empresas)
        
    }
    
    required init() { }
    override func map(map: JSON) {
        super.map(map: map)
        self.cabResponse <- map[Keys.cabResponse.rawValue]
        self.empresas <> map[Keys.empresas.rawValue]
        
    }
    
    func get<T>(_ key: Keys) -> T {
        switch key {
        case .cabResponse: return cabResponse as! T
        case .empresas: return empresas as! T
        }
    }
    
}
