//
//  UnidadTrabajoViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 2/14/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

class UnidadTrabajoViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var btnDoNotHavePlace: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var switchPlaces: UISwitch!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = "Selecciona tus \n lugares de trabajo:"
        
    }
    
    // MARK: Actions
    @IBAction func btnBackDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnShowPlacesDidTap(_ sender: Any) {
        debugPrint("btnShowPlacesDidTap")
    }
    
    @IBAction func placeSwitchDidChange(_ sender: Any) {
        debugPrint("placeSwitchDidChange")
    }
    
    @IBAction func btnContinueDidTap(_ sender: Any) {
        debugPrint("btnContinueDidTap")
    }
    
    @IBAction func btnDoNotHavePlaceDidTap(_ sender: Any) {
        debugPrint("btnDoNotHavePlace")
    }
    
}


// MARK: UITableViewFeatures
extension UnidadTrabajoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.makeViewWith(features: [.color(indexPath.row%2 == 0 ? .white : .lightGray)])
        return cell
    }
}
