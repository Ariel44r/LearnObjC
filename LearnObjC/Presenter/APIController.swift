//
//  APIController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/17/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class APIController: API {
    @objc func post2API(WS: WebService, completion: @escaping(Any?) -> Void) {
        self.request(WS: WS, completion: { (response: SocioProTreeResponse?) in
            if let encodedData = try? JSONEncoder().encode(response!) {
                if let json = String(data: encodedData, encoding: .utf8) {
                    debugPrint("Encoded Json: \(json)")
                    
                }
            }
            completion(response)
            
        })
    }
}
