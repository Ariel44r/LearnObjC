//
//  DoNotHavePlaceInfoViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 2/18/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

class DoNotHavePlaceInfoViewController: UIViewController {

    override func viewDidLoad() { super.viewDidLoad() }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.makeViewWith(features: [.color(UIColor.black.withAlphaComponent(0.6))])
            
        })
    }
    
    @IBAction func btnDismissInfo(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.makeViewWith(features: [.color(.clear)])
            
        }, completion: { _ in
            self.dismiss(animated: true, completion: nil)

        })
    }

}
