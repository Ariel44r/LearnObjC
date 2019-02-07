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

        // Do any additional setup after loading the view.
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.title = "Title for Navigation"
        self.getSocioProTree()
        
    }
    
    func getSocioProTree() {
        APIController().post2API(WS: WebService(endPoint: "https://sproapi-staging.vapor.cloud/JWT_ConsultaEstructura", method: .POST, parameters: [:], headers: [:], name: "SocioProTree" ), completion: { socioProTreeResponse in
            if let jsonstring: String = JSONSerializer.toString(with: socioProTreeResponse) as String? {
                debugPrint(jsonstring)
                
            }
        })
    }

}

// MARK: UITableViewDelegate
extension SwiftViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 32
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.makeViewWith(features: [.color(indexPath.row%2==0 ? .white : .lightGray)])
        cell.selectionStyle = .none
        return cell
        
    }
}
