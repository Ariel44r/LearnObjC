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
    var titles: [String] = []

    // MRK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Tracks List"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.searchController = UISearchController(searchResultsController: nil)
        }
        if let _ = self.tracks as [TrackObject]? {
            self.grouppedTracks()
            self.titles =  self.getHeaderTitles()
            self.tableView.reloadData()
            
        }
    }
    
    // MARK: OwnMethods
    func grouppedTracks() {
        var tempTracks: [TrackObject] = []
        let arrivedDates: [Double] = self.tracks!.map({ $0.arrivalDate }).uniqueElements
        arrivedDates.forEach({ arrivalDate in
            let grouppedTracks: [TrackObject] = self.tracks!.filter({ $0.arrivalDate == arrivalDate || abs($0.arrivalDate - arrivalDate) < 60 })
            if grouppedTracks.count > 1 {
                grouppedTracks[1].departurDate = grouppedTracks[0].departurDate
                grouppedTracks[1].iscomplete = true
                tempTracks.append(grouppedTracks[1])
                
            } else {
                tempTracks.append(grouppedTracks[0])
                
            }
        })
        self.tracks = tempTracks
        
    }
    
    func getHeaderTitles() -> [String] {
        self.tracks?.forEach({
            debugPrint($0.dateNow)
            let fullString: String = Date(timeIntervalSince1970: $0.arrivalDate).description(with: .autoupdatingCurrent)
            let arrayString: [String] = fullString.replacingOccurrences(of: "Central Standard Time", with: "").components(separatedBy: ",")
            self.titles.append("\(arrayString[0]),\(arrayString[1])")
            
        })
        var uniqueTitles = self.titles.uniqueElements
        uniqueTitles.remove(at: uniqueTitles.count-1)
        return uniqueTitles
        
    }

}

extension Sequence where Element: Equatable {
    var uniqueElements: [Element] {
        return self.reduce(into: []) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}

// MARK: UITableViewStubs
extension DetailLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: TitleTableViewCell = UIView.fromNib()
        view.set(title: self.titles[section])
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titles.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250//hardCode heightForRow
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.tableDataSource {
        case .original:
            return self.tracks!.filter({ $0.dateNow!.contains(self.titles[section]) }).count
        case .filter: return self.filterTracks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackObject = self.tableDataSource == .filter ? self.filterTracks[indexPath.row] : self.tracks!.filter({ $0.dateNow.contains(self.titles[indexPath.section])})[indexPath.row]
        return {
            let cell: TrackCellTableViewCell = UIView.fromNib()
            cell.set(trackObject)
            return cell
            
        }()
    }
    
}
