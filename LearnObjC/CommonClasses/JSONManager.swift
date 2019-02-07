//
//  JSONManager.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/3/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]
public typealias JSONData = Data
public typealias JSONString = String

public class JSONSerializer {
    public class func object<T: Codable>(with JSONData: JSONData) -> T? {
        return try? JSONDecoder().decode(T.self, from: JSONData)
        
    }
    
    public class func object<T: Codable>(with JSONString: JSONString) -> T? {
        if let jsonData: JSONData = JSONString.data(using: .utf8),
            let object: T = try? JSONDecoder().decode(T.self, from: jsonData) {
            return object
            
        }
        return nil
    }
    
    public class func toJSONData<T: Codable>(with object: T) -> JSONData? {
        return try? JSONEncoder().encode(object)
        
    }
    
    public class func toString<T: Encodable>(with object: T) -> JSONString? {
        if let jsonData = try? JSONEncoder().encode(object) {
            if let jsonString: JSONString = String(data: jsonData, encoding: .utf8) {
                return jsonString
                
            }
        }
        return nil
    }
}
