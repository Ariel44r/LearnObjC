//
//  RouterViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 2/11/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

@objc enum NavigationItems: Int { case back, burguer, nofications }

@IBDesignable class RouterViewController: UINavigationController {
    @IBInspectable var navigationBarType: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
}
