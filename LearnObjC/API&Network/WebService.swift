//
//  WebService.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc enum HTTPMethod: NSInteger { case GET, POST, PUT, PATCH, DELETE }

enum HTTPMethodName: String {
    case GET = "get"
    case POST = "post"
    case PUT = "put"
    case PATCH = "patch"
    case DELETE = "delete"

}

typealias HTTPHeaders = [String: String]
typealias HTTPBody = [String: Any]

@objc class WebService: NSObject {
    var baseURL: String! = App.MetaData.baseURL
    var url: String!
    var urlRequest: URLRequest!
    var method: HTTPMethodName!
    var parameters: HTTPBody = [:]
    var headers: HTTPHeaders!
    var name: String!
    
    @objc init(endPoint: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders?, name: String?) {
        self.parameters = parameters ?? [:]
        self.headers = headers ?? [:]
        self.url = endPoint
        switch method {
        case .GET: self.method = .GET
        case .POST: self.method = .POST
        case .PUT: self.method = .PUT
        case .PATCH: self.method = .PATCH
        case .DELETE: self.method = .DELETE
        }
        self.urlRequest = URLRequest(url: URL(string: self.url)!)
        self.urlRequest.httpMethod = self.method.rawValue
        self.urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: self.parameters, options: [])
        self.urlRequest.allHTTPHeaderFields = self.headers
        self.urlRequest.timeoutInterval = 15
        self.name = name ?? "withOutName"
        
    }
    
}
