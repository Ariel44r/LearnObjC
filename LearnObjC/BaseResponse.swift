//
//  BaseResponse.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class BaseResponse: NSObject {
    @objc var responseCode: Int = -1
    @objc var message: String?
    
    override init() { }
    
}
