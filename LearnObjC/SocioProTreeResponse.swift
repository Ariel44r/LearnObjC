//
//  SocioProTreeResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/3/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation
import ObjectMapper

//@objc class SocioProTreeResponse: NSObject, Mappable {
//    @objc private var cabResponse: CabResponse = CabResponse()
//    @objc private var responseSocio: String! = nil
//    @objc private var empresas: [Empresa] = []
//    
//    override init() { }
//    required init?(map: Map) { }
//    func mapping(map: Map) {
//        self.cabResponse <- map["cabResponse"]
//        self.responseSocio <- map["responseSocio"]
//        if let data: Data = self.responseSocio.data(using: .utf8),
//        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
//        let empresas: [Empresa] = Mapper<Empresa>().mapArray(JSONObject: json) {
//            self.empresas = empresas
//            
//        }
//    }
//    
//    @objc func getEmpresas() -> [Empresa] { return self.empresas }
//    
//}
