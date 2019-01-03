//
//  BaseResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import ObjectMapper

@objc class BaseResponse: NSObject, Mappable {
    var responseCode: Int!
    var message: String?
    
    override init(){ }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        self.responseCode <- map["responseCode"]
        self.message <- map["message"]
        
    }
}
