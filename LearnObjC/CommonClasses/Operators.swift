//
//  Operators.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/3/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

// MARK: - ForwardPipe operator
infix operator |> : ForwardPipeOperator

precedencegroup ForwardPipeOperator {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    
}

func |> <T, U>(value: T, function: ((T) -> U)) -> U {
    return function(value)
    
}
