//
//  UIViewControllerExtension.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 2/12/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc func setNavigation(features: [Any]) {
        if let navigationController = self.navigationController as? RouterViewController {
            navigationController.set(controller: self, features: features)
            
        }
    }
}
