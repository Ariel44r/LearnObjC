//
//  WebService.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

enum WS {
    case login, signUp, socioProTreeResponse
    
}

@objc class WebService: NSObject {
    var baseURL: String! = App.MetaData.baseURL
    var WS: WS!
    var requestURL: String!
    var method: HTTPMethod!
    var parameters: [String: Any] = [:]
    var headers: HTTPHeaders!
    var encoding: ParameterEncoding!
    var name: String!
    var showActivityViewWhileRequest: Bool! = true

    init(WS: WS, _ parameters: [String: Any], _ headers: HTTPHeaders) {
        self.parameters = parameters
        self.headers = headers
        switch WS {
        case .login:
            self.requestURL = self.baseURL + ""
            self.method = .get
            self.encoding = JSONEncoding.default
            
        case .signUp:
            break;
            
        case .socioProTreeResponse:
            self.name = "SocioPro -> ConsultaEstructura"
            self.requestURL = self.baseURL + "/JWT_ConsultaEstructura"
            self.method = .post
            self.encoding = JSONEncoding.default
            
        default:
            break
        }
    }
    
    func getName() -> String {
        return self.name
        
    }
}
