//
//  UnidadTrabajoViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 2/14/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit
import ObjectiveC

class UnidadTrabajoViewController: UIViewController {
    
    // MARK: Attributes
    var placesToWork: [String] = []
    
    // MARK: Outlets
    @IBOutlet weak var btnDoNotHavePlace: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var switchPlaces: UISwitch!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = "Selecciona tus \n lugares de trabajo:"
        UserDefaults.standard.set(true, forKey: "canRotateViewControllerFlag")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(nil, forKey: "canRotateViewControllerFlag")
        
    }
    
    // MARK: Actions
    @IBAction func btnBackDidTap(_ sender: Any) { self.navigationController?.popViewController(animated: true) }
    
    @IBAction func btnDoNotHavePlaceDidTap(_ sender: Any) {
        self.performSegue(withIdentifier: "doNotHavePlaceSegue", sender: nil)
        
    }
    
    @IBAction func placeSwitchDidChange(_ sender: UISwitch) {
        if sender.isOn {
            self.performSegue(withIdentifier: "doNotHavePlaceSegue", sender: nil)
            
        }
    }
    
    @IBAction func btnShowPlacesDidTap(_ sender: UIButton) {
        self.tableView.beginUpdates()
        self.placesToWork.append("Torre GS")
        self.tableView.insertRows(at: [IndexPath(row: placesToWork.count - 1, section: 0)], with: .middle)
        self.tableView.endUpdates()
        
    }
    
    @objc func deletePlaceToWork(_ sender: UIButton) {
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .middle)
        self.placesToWork.remove(at: sender.tag)
        self.tableView.endUpdates()
        
    }
    
    @IBAction func btnContinueDidTap(_ sender: Any) {
        debugPrint("btnContinueDidTap")
    }
}

// MARK: UITableViewFeatures
extension UnidadTrabajoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.placesToWork.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 55 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlacesTableViewCell = UIView.fromNib()
        cell.btnDelete.addTarget(self, action: #selector(self.deletePlaceToWork(_:)), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        return cell
        
    }
}
