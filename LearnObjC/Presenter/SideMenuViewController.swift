//
//  BaseViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/29/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

@objc enum SideMenuType: Int { case overView, shiftView }

@objc class SideMenuViewController: UIViewController {
    var appDelegate: AppDelegate!
    var window: UIWindow!
    var appFrame: CGRect!
    var sideMenu: UIView!
    var panGesture: UIPanGestureRecognizer!
    var isOpen: Bool = false
    var burgerItem: UIBarButtonItem!
    var maxWidth: CGFloat!
    var tableSideMenu: TableSideMenu!
    let statusBarHeight: CGFloat = 24
    var blurView: UIView!
    var sideMenuType: SideMenuType = .overView

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
        
    }
    
    @objc func setLayout() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.window = self.appDelegate.window
        self.appFrame = self.window.frame
        self.maxWidth = 300
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
        self.view.addGestureRecognizer(self.panGesture)
        self.blurView = {
            let view = UIView()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showBurgerMenu(_:)))
            view.addGestureRecognizer(tapGesture)
            view.alpha = 0
            view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            return view
        }()
        self.sideMenu = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: appFrame.height))
            view.makeViewWith(features: [.color(.get(.blue))])
            self.tableSideMenu = TableSideMenu.shared
            view.addSubview(self.tableSideMenu.tableView)
            return view
        }()
        self.appDelegate.window.addSubview(sideMenu)
        self.tableSideMenu.set()
        self.tableSideMenu.tableView.frame = CGRect(x: 0, y: self.statusBarHeight, width: self.sideMenu.frame.width, height: self.sideMenu.frame.height - self.statusBarHeight)
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if self.isOpen {
            self.completeAmination()
            
        }
    }
    
    // MARK: Targets
    @objc func showBurgerMenu(_ sender: Any) {
        self.isOpen = !self.isOpen
        self.completeAmination()
        
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        if self.tableSideMenu == nil { self.setLayout() }
        self.appFrame = self.window.frame
        let offset: CGPoint = sender.translation(in: window)
        switch sender.state {
        case .changed:
            if self.sideMenu.frame.width <= 0.85*appFrame.width && (!self.isOpen ? offset.x > 0 : self.sideMenu.frame.width > 0) && (self.maxWidth + offset.x) >= 0 {
                self.sideMenu.frame = CGRect(x: 0, y: 0, width: self.isOpen ? self.maxWidth + offset.x : offset.x, height: appFrame.height)
                self.tableSideMenu.tableView.frame = CGRect(x: 0, y: self.statusBarHeight, width: self.isOpen ? self.maxWidth + offset.x : offset.x, height: appFrame.height - self.statusBarHeight)
                if let layoutContainerView: UIView = window?.rootViewController?.view as UIView? {
                    layoutContainerView.frame = CGRect(x: self.sideMenuType == .shiftView ? self.sideMenu.frame.width : 0, y: 0, width: appFrame.width, height: appFrame.height)
                    
                }
            }
        case .ended:
            self.isOpen = offset.x > 100
            self.completeAmination()
            
        default: break
        }
    }
    
    @objc func completeAmination() {
        if self.tableSideMenu == nil { self.setLayout() }
        self.appFrame = self.window.frame
        UIView.animate(withDuration: 0.2, animations: {
            self.sideMenu.frame = CGRect(x: 0, y: 0, width: self.isOpen ? self.maxWidth : 0, height: self.appFrame.height)
            self.tableSideMenu.tableView.frame = CGRect(x: 0, y: self.statusBarHeight, width: self.isOpen ? self.maxWidth : 0, height: self.appFrame.height - self.statusBarHeight)
            if let layoutContainerView: UIView = self.window?.rootViewController?.view as UIView? {
                layoutContainerView.frame = CGRect(x: self.isOpen ? (self.sideMenuType == .shiftView ? self.maxWidth : 0) : 0, y: 0, width: self.appFrame.width, height: self.appFrame.height)
                
            }
        }, completion: self.blurViewWillOnOff)
    }
    
    @objc func blurViewWillOnOff(_: Bool) {
        self.isOpen ? self.blurView.addGestureRecognizer(self.panGesture) : self.view.addGestureRecognizer(self.panGesture)
        if let layoutContainerView: UIView = window?.rootViewController?.view as UIView? {
            self.blurView.frame = layoutContainerView.bounds
            UIView.animate(withDuration: 0.3, animations: {
                self.blurView.alpha = self.isOpen ? 1 : 0
                self.isOpen ? layoutContainerView.addSubview(self.blurView) : self.blurView.removeFromSuperview()

            }, completion: { _ in
                if !self.isOpen {
                    self.tableSideMenu = nil
                    
                }
            })
        }
    }

}

// MARK: UITableViewFeatures
@objc class TableSideMenu: NSObject, UITableViewDelegate, UITableViewDataSource {
    @objc static var shared: TableSideMenu! = TableSideMenu()
    @objc var tableView = UITableView()
    @objc var viewControllers: [UIViewController]!
    
    override init() {
        debugPrint("SideTable did instanced")
    }
    
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
        cell.textLabel?.text = "hey, this is only for development purpose"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.3, animations: { cell.alpha = 1 })
        
    }
}
