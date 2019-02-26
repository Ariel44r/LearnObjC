//
//  UIColorExtension.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/29/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

extension UIColor {
    
    enum Color {
        case blue
    }
    
    class func get(_ color: Color) -> UIColor {
        switch color {
        case .blue:
            return UIColor(red: 15/255.0, green: 16/255.0, blue: 48/255.0, alpha: 1).withAlphaComponent(1)
            
        }
    }
    
}
