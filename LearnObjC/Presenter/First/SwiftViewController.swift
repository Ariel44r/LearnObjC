//
//  SwiftViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/29/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

class SwiftViewController: SideMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.getSocioProTree()
        self.setNavigation(features: [NavigationFeature.burger, NavigationFeature.notifications])
        self.title = "development purpose"

    }
    
    func getSocioProTree() {
        APIController().post2API(WS: WebService(endPoint: "https://sproapi-staging.vapor.cloud/JWT_ConsultaEstructura", method: .POST, parameters: [:], headers: [:], name: "SocioProTree"), completion: { socioProTreeResponse in
            if let jsonString: String = JSONSerializer.toString(with: socioProTreeResponse) as String? {
                debugPrint(jsonString)
                
            }
        })
    }

}

// MARK: UITableViewDelegate
extension SwiftViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 64
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.makeViewWith(features: [.color(indexPath.row%2==0 ? .white : .lightGray)])
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            cell.alpha = 1
            
        })
    }
}

extension SwiftViewController: NavigationDelegate {
    func burgerButtonDidTap(_ sender: UIBarButtonItem) {
        debugPrint("burger button did tap from SwiftViewController!")
        
    }
}
