//
//  AlertcontrollerManager.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

@objc public class AlertControllerManager: NSObject {
    
    public static var alert: UIAlertController!
    public static var alertStyle: UIAlertController.Style!
    
    @objc class func showAlert(controller: UIViewController?, alertStyle: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction]?) {
        if let _ = self.getTopViewController() as? UIAlertController {
            debugPrint("AlertControllerWillNotPresent")
            
        } else {
            debugPrint("AlertControllerWillPresent")
            self.alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
            if let actions = actions as [UIAlertAction]? {
                actions.forEach({ self.alert.addAction($0) })
                
            } else {
                self.alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: { action in
                    self.alert.dismiss(animated: true, completion: nil)

                }))
            }
            if let controller = controller as UIViewController? {
                controller.present(self.alert, animated: true, completion: nil)
                
            } else {
                self.getTopViewController().present(self.alert, animated: true, completion: nil)
                
            }
        }
    }
    
    @objc class func getTopViewController() -> UIViewController {
        var topViewController = UIApplication.shared.delegate!.window!!.rootViewController!
        while (topViewController.presentedViewController != nil) {
            if(topViewController.isKind(of: UINavigationController.classForCoder())){
                topViewController = (topViewController as! UINavigationController).viewControllers.last!
                
            }else{
                topViewController = topViewController.presentedViewController!
                
            }
        }
        return topViewController
        
    }
    
}
