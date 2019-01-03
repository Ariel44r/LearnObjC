//
//  UIViewExtension.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

enum ViewFeatures {
    case rounded, shadow, color(UIColor), bordered(UIColor, CGFloat), image(UIImage), roundedView(RoundedType, UIColor), topRounded, fullRounded
}

enum RoundedType {
    case full, onlyLayer
}

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
        
    }
    
    func makeViewWith(features: [ViewFeatures]?) {
        if let features = features as [ViewFeatures]? {
            features.forEach({
                switch $0 {
                case .rounded:
                    self.layer.cornerRadius = 10
                    
                case .shadow:
                    self.setShadow()
                    
                case .color(let color):
                    self.backgroundColor = color
                    
                case .bordered(let color, let borderWidth):
                    self.setCornerRadius(color: color, borderWidth: borderWidth)
                    
                case .image(let image):
                    (self as! UIImageView).image = image
                    
                case .roundedView(let roundedType, let color):
                    self.setRounded(roundedType: roundedType, color: color)
                    
                case .topRounded:
                    self.setTopRounded()
                    
                case .fullRounded:
                    self.setFullRounded()
                    
                }
            })
        }
    }
    
    @objc func setTopRounded() {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 30, height:  30))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    @objc func setFullRounded() {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners:[.topRight, .topLeft, .bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 10, height:  10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func setRounded(roundedType: RoundedType, color: UIColor) {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    @objc func setShadow(){
        var bounds:CGRect = self.bounds
        if self.isKind(of: UITableView.classForCoder()){
            let headerHeight = (self as! UITableView).headerView(forSection: 0)?.frame.height ?? 0
            bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: (self as! UITableView).contentSize.height - headerHeight)
        }
        
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
    }
    
    @objc func setCornerRadius(color: UIColor, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        
    }
    
}
