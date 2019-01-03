//
//  JSONManager.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/3/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import ObjectMapper

public class JSONManager {
    public class func getObject<T: Mappable>(jsonData: Data) -> T? {
        return Mapper<T>().map(JSONObject: jsonData)
        
    }
    
    public class func getObject<T: Mappable>(jsonString: String) -> T? {
        return Mapper<T>().map(JSONString: jsonString)
        
    }
    
    public class func getJsonString<T: Mappable>(object: T) -> String {
        return object.toJSONString()!
        
    }

}
