//
//  SecondViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 2/11/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

class SecondViewController: SideMenuViewController {
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setNavigation(features: [NavigationFeature.burger, NavigationFeature.notifications])
        self.title = "navigation title"
        
    }

}

extension SecondViewController: NavigationDelegate {
    func burgerButtonDidTap(_ sender: UIBarButtonItem) {
        debugPrint("burger button did tap from SecondViewController!")
        
    }
}
