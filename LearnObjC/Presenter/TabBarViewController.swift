//
//  TabBarViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 3/13/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: Instances
    var tabBarItemElements: [(String, UIImage)]!
    let heightForTabBar: CGFloat = 75
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        delegate = self
        self.tabBarItemElements = [
            ("Sólo para ti", #imageLiteral(resourceName: "ic_my_location")),
            ("Seguros", #imageLiteral(resourceName: "ic_my_location")),
            ("Convenios", #imageLiteral(resourceName: "ic_my_location"))
        ]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        self.tabBar.invalidateIntrinsicContentSize()
        let width = self.tabBar.frame.width
        let yPositionForTabBar: CGFloat = self.isIphoneX() ? 84 : 64
        self.tabBar.frame = CGRect(x: 0, y: yPositionForTabBar, width: width, height: self.heightForTabBar)
        self.tabBar.tintColor = .green
        for i in 0..<tabBarItemElements.count {
            self.tabBar.items![i].image = self.tabBarItemElements[i].1
            self.tabBar.items![i].tag = i
            self.tabBar.items![i].title = self.tabBarItemElements[i].0
            
        }
    }
    
    // MARK: Methods
    //Check if statusBarHeight is greater than standard iphone statusBar
    func isIphoneX() -> Bool {
        return UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436
        
    }
    
    func popTabBarcontroller() {
        //        let centerView = App.drawerViewController.centerViewController as! UINavigationController
        //        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        //        appDelegate.window?.rootViewController = App.drawerViewController
        if self.navigationController?.popViewController(animated: true) == nil {
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func hiddeShowTabBar(_ present: Bool) {
        if present {
            UIView.animate(withDuration: 0.5, animations: {
                self.tabBar.alpha = 1
                
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.tabBar.alpha = 0
                
            })
        }
    }
    
    func changeItemName(item: Int, name: String) {
        self.tabBar.items![item].title = name
        
    }
    
}

// MARK: TabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        if fromView != toView {
            switch tabBarController.tabBar.selectedItem?.tag {
            case 0:
                tabBarController.tabBar.tintColor = .green
                
            case 1:
                tabBarController.tabBar.tintColor = .blue
                
            case 2:
                tabBarController.tabBar.tintColor = .yellow
                
            case 3:
                tabBarController.tabBar.tintColor = .brown
                
            default:
                tabBarController.tabBar.tintColor = .lightGray
                
            }
            UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromLeft], completion: nil)
            
        }
        return true
        
    }
}

