//
//  BaseViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/29/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    var sideMenu: UIView!
    var panGesture: UIPanGestureRecognizer!
    var isOpen: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.sideMenu = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: appDelegate.window.frame.height))
        appDelegate.window.addSubview(sideMenu)
        self.sideMenu.makeViewWith(features: [.color(.get(.blue))])
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
        self.view.addGestureRecognizer(self.panGesture)

        // Do any additional setup after loading the view.
    }
    
    // MARK: Targets
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appFrame: CGRect = appDelegate.window.frame
        let offset: CGPoint = sender.translation(in: appDelegate.window)
        switch sender.state {
        case .changed:
            if offset.x <= 0.8*appFrame.width {
                self.sideMenu.frame = CGRect(x: 0, y: 0, width: self.isOpen ? 0.8*appFrame.width : 0 + offset.x, height: appFrame.height)
                
            }
        case .ended:
            self.isOpen = offset.x > 100
            UIView.animate(withDuration: 0.3, animations: {
                self.sideMenu.frame = CGRect(x: 0, y: 0, width: offset.x > 100 ? 0.8*appFrame.width : 0, height: appFrame.height)
                
            })
        default: break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
