//
//  ActivityIndicatorManager.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

enum ProgressViewWill { case appear, disappear }

class ActivityIndicatorManager: UIView {
    
    // MARK: Attributes
    var activityProgress: UIActivityIndicatorView!
    public static var instance: ActivityIndicatorManager = ActivityIndicatorManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.activityProgress = UIActivityIndicatorView(style: .whiteLarge)
        self.addSubview(self.activityProgress)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // MARK: Methods
    func progressViewWill(_ action: ProgressViewWill) {
        if action == .appear {
            self.alpha = 0
            let controller = AlertControllerManager.getTopViewController()
            controller.view.addSubview(self)
            self.center = controller.view.center
            self.frame = controller.view.bounds
            self.activityProgress.startAnimating()
            self.activityProgress.center = self.center
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 1
                
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.addSubview(self.activityProgress)
                self.activityProgress.center = self.center
                self.activityProgress.startAnimating()
                self.alpha = 0
                
            }, completion: { _ in
                self.removeFromSuperview()
                
            })
        }
        self.makeViewWith(features: [.color(UIColor.black.withAlphaComponent(0.8))])
        
    }
}
