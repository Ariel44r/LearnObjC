//
//  DetailLocationViewController.swift
//  Socio MAS
//
//  Created by ARIEL DIAZ on 3/7/19.
//  Copyright © 2019 Diego Yael. All rights reserved.
//

import UIKit
import MapKit

enum TableDataSource { case filter, original }

class DetailLocationViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Attributes
    var tracks: [TrackObject]?
    var filterTracks: [TrackObject] = []
    var tableDataSource: TableDataSource = .original

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Tracks List"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.searchController = UISearchController(searchResultsController: nil)
        }
        self.tableView.reloadData()
        
    }

}

// MARK: UITableView
extension DetailLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300//hardCode heightForRow
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.tableDataSource {
        case .original: return self.tracks?.count ?? 0
        case .filter: return self.filterTracks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackObject = self.tableDataSource == .filter ? self.filterTracks[indexPath.row] : self.tracks![indexPath.row]
        return {
            let cell: TrackCellTableViewCell = UIView.fromNib()
            cell.set(trackObject)
            return cell
            
        }()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TrackCellTableViewCell {
            cell.willAppear()
            
        }
    }
    
}

// MARK: UITableViewCell
class MyCell: UITableViewCell {
    
    @IBOutlet weak var dateNow: UILabel!
    @IBOutlet weak var arrived: UILabel!
    @IBOutlet weak var ended: UILabel!
    
    func set(_ trackObject: TrackObject) {
        self.dateNow.text = "dateNow: \n\(trackObject.dateNow!)"
            .replacingOccurrences(of: "Central Standard Time", with: "")
        self.arrived.text = "arrived: \n\(Date(timeIntervalSince1970: trackObject.arrivalDate).description(with: .current))"
            .replacingOccurrences(of: "Central Standard Time", with: "")
        self.ended.text = "departur: \n\(Date(timeIntervalSince1970: trackObject.departurDate).description(with: .current))"
            .replacingOccurrences(of: "Central Standard Time", with: "")
        
    }
    
}
