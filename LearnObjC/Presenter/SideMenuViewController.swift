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
    var burgerItem: UIBarButtonItem!
    var maxWidth: CGFloat!
    var sideTable: TableSideMenu = TableSideMenu()
    let statusBarHeight: CGFloat = 24
    var blurView: UIView!
    var viewControllers: [UIViewController]?

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appFrame: CGRect = appDelegate.window.frame
        self.maxWidth = 300
        self.sideMenu = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: appFrame.height))
        self.sideMenu.makeViewWith(features: [.color(.get(.blue))])
        appDelegate.window.addSubview(sideMenu)
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
        appDelegate.window.addGestureRecognizer(self.panGesture)
        self.blurView = {
            let view = UIView()
            view.alpha = 0
            view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            view.frame = CGRect(x: self.maxWidth, y: 0, width: appFrame.width - self.maxWidth, height: appFrame.height)
            return view
        }()
        self.burgerItem = {
            let burgerIcon: UIImage = #imageLiteral(resourceName: "ic_burger_menu")
            let barItem = UIBarButtonItem(image: burgerIcon, style: .done, target: self, action: #selector(self.showBurgerMenu(_:)))
            barItem.tintColor = .white
            return barItem
        }()
        self.navigationItem.leftBarButtonItem = self.burgerItem
        self.sideMenu.addSubview(self.sideTable.tableView)
        self.sideTable.set()
        self.sideTable.tableView.frame = CGRect(x: 0, y: self.statusBarHeight, width: self.sideMenu.frame.width, height: self.sideMenu.frame.height - self.statusBarHeight)
        // Do any additional setup after loading the view.
        
    }
    
    // MARK: Targets
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appFrame: CGRect = appDelegate.window.frame
        let window = appDelegate.window
        let offset: CGPoint = sender.translation(in: appDelegate.window)
        switch sender.state {
        case .changed:
            if self.sideMenu.frame.width <= 0.85*appFrame.width && (!self.isOpen ? offset.x > 0 : self.sideMenu.frame.width > 0) {
                self.sideMenu.frame = CGRect(x: 0, y: 0, width: self.isOpen ? self.maxWidth + offset.x : offset.x, height: appFrame.height)
                self.sideTable.tableView.frame = CGRect(x: 0, y: self.statusBarHeight, width: self.isOpen ? self.maxWidth + offset.x : offset.x, height: appFrame.height - self.statusBarHeight)
                if let layoutContainerView: UIView = window?.rootViewController?.view as UIView? {
                    layoutContainerView.frame = CGRect(x: self.sideMenu.frame.width, y: 0, width: appFrame.width, height: appFrame.height)
                    
                }
            }
        case .ended:
            self.isOpen = offset.x > 100
            UIView.animate(withDuration: 0.3, animations: {
                self.sideMenu.frame = CGRect(x: 0, y: 0, width: self.isOpen ? self.maxWidth : 0, height: appFrame.height)
                self.sideTable.tableView.frame = CGRect(x: 0, y: self.statusBarHeight, width: self.isOpen ? self.maxWidth : 0, height: appFrame.height - self.statusBarHeight)
                if let layoutContainerView: UIView = window?.rootViewController?.view as UIView? {
                    layoutContainerView.frame = CGRect(x: self.isOpen ? self.maxWidth : 0, y: 0, width: appFrame.width, height: appFrame.height)
                    
                }
            }, completion: self.blurViewWillOnOff)
        default: break
        }
    }
    
    @objc func showBurgerMenu(_ sender: Any) {
        let appFrame: CGRect = (UIApplication.shared.delegate as! AppDelegate).window.frame
        UIView.animate(withDuration: 0.3, animations: {
            self.sideMenu.frame = CGRect(x: 0, y: 0, width: self.isOpen ? 0 : 0.8*self.view.frame.width, height: appFrame.height)
            self.sideTable.tableView.frame = self.isOpen ? CGRect(x: 0, y: self.statusBarHeight, width: self.maxWidth, height: appFrame.height - self.statusBarHeight) : appFrame
            
        }, completion: self.blurViewWillOnOff)
        self.isOpen = !self.isOpen
    }
    
    func blurViewWillOnOff(_: Bool) {
        debugPrint("__[blurViewWill]: \(self.isOpen ? " [On]" : " [Off]")")
        UIView.animate(withDuration: 0.3, animations: { self.blurView.alpha = self.isOpen ? 1 : 0 })
        
    }

}

// MARK: UITableViewFeatures
@objc class TableSideMenu: NSObject, UITableViewDelegate, UITableViewDataSource {
    @objc var tableView = UITableView()
    
    override init() {}
    
    func set() {
        self.tableView = {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.separatorStyle = .none
            self.tableView.makeViewWith(features: [.color(.clear)])
            return self.tableView
        }()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = UIView()
        view.makeViewWith(features: [.color(.clear)])
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 120 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 44 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.makeViewWith(features: [.color(indexPath.row%2==0 ? .white : .lightGray)])
        return cell
        
    }
}
