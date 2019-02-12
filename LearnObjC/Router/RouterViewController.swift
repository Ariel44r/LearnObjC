//
//  RouterViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 2/11/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

@objc enum NavigationFeature: Int { case back, burger, notifications }

@objc protocol NavigationDelegate {
    @objc optional func backButtonDidTap(_ sender: UIBarButtonItem)
    @objc optional func burgerButtonDidTap(_ sender: UIBarButtonItem)
    @objc optional func notificationsButtonDidTap(_ sender: UIBarButtonItem)
    
}

@IBDesignable
@objc class RouterViewController: UINavigationController {
    
    // MARK: Attributes
    @objc var navigationDelegate: NavigationDelegate?
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    // MARK: Methods
    @objc func set(controller: UIViewController, features: [Any]) {
        if let navigationDelegate = controller as? NavigationDelegate {
            self.navigationDelegate = navigationDelegate
            controller.navigationItem.leftBarButtonItems = []
            controller.navigationItem.rightBarButtonItems = []
            if let features = features as? [NavigationFeature] {
                features.forEach({
                    switch $0 {
                    case .back:
                        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_burger_sidemenu"), style: .done, target: self, action: #selector(self.backButton(_:)))
                        controller.navigationItem.leftBarButtonItems!.append(backButton)
                    case .burger:
                        let burgerButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_burger_sidemenu"), style: .done, target: self, action: #selector(self.burgerButton(_:)))
                        controller.navigationItem.leftBarButtonItems!.append(burgerButton)
                    case .notifications:
                        let notificationsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_burger_sidemenu"), style: .done, target: self, action: #selector(self.backButton(_:)))
                        controller.navigationItem.rightBarButtonItems!.append(notificationsButton)
                    }
                })
            }
        }
    }
    
    @objc func backButton(_ sender: UIBarButtonItem) {
        
    }
    
    @objc func burgerButton(_ sender: UIBarButtonItem) {
        if let controller = self.navigationDelegate as? SideMenuViewController {
            controller.showBurgerMenu("")
            
        }
    }
    
    @objc func notifications(_ sender: UIBarButtonItem) {
        self.navigationDelegate?.notificationsButtonDidTap?(sender)
        
    }
    
}
