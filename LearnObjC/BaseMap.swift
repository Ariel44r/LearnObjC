//
//  BaseResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc public protocol MapDelegate {
    func map(map: JSON)
    
}

@objc class BaseMap: NSObject, MapDelegate, Encodable {
    required override init() { }
    func encode(to encoder: Encoder) throws { }
    func map(map: JSON) { }
    
}

@objc public class LOG: NSObject {
    @objc class func debugLog(_ object: Any) {
        debugPrint(object)
        
    }
}
