//
//  Operators.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/3/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//
//  let obj = type(of: objectArray).Element.self.init()

import Foundation
import Swift

// MARK: - ForwardPipe operator
infix operator |> : ForwardPipeOperator

precedencegroup ForwardPipeOperator {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    
}

func |> <T, U>(value: T, function: ((T) -> U)) -> U {
    return function(value)
    
}

// MARK: MapOperator
infix operator <- : MapOperator

precedencegroup MapOperator {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    
}

func <- <T>(object: inout T, map: Any?) {
    if let raw = map as? T {
        object = raw
        
    } else if let dict: JSON = map as? JSON,
        let objectMappable: BaseMap = object as? BaseMap {
        objectMappable.map(map: dict)
        
    }
}

// MARK: MapArrayOperator
infix operator <> : MapArrayOperator

precedencegroup MapArrayOperator {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    
}

func <> <T: BaseMap>(object: inout [T], map: Any?) {
    if let mapArray = map as? [Any] {
        mapArray.forEach({
            if let mapDict: JSON = $0 as? JSON {
                let obj = T.init()
                obj.map(map: mapDict)
                object.append(obj)
                
            }
        })
    } else if let mapString: String = map as? String,
        let data: Data = mapString.data(using: .utf8),
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
        let mapArray: [Any] = json as? [Any] {
        mapArray.forEach({
            if let mapDict: JSON = $0 as? JSON {
                let obj = T.init()
                obj.map(map: mapDict)
                object.append(obj)
                
            }
        })
    }
}
