//
//  APIController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/17/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class APIController: API {
    
    @objc func post2API(WS: WebService, completion: @escaping(SocioProTreeResponse?) -> Void) {
        self.request(WS: WS, completion: { (response: SocioProTreeResponse?) in
            completion(response)
            
        })
    }
    
    @objc func post2API2(WS: WebService, completion: @escaping(ListadoResponse?) -> Void) {
        self.request(WS: WS, completion: { (response: ListadoResponse?) in
            completion(response)
            
        })
    }
    
    @objc func getDocument(WS: WebService, completion: @escaping(DocumentoResponse?) -> Void) {
        self.request(WS: WS, completion: { (response: DocumentoResponse?) in
            completion(response)
            
        })
    }
    
}
