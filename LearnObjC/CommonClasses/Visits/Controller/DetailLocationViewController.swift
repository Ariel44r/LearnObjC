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
    var tracks: [TrackObject] = []
    var filterTracks: [TrackObject] = []
    var tableDataSource: TableDataSource = .original
    var titles: [String] = []
    let searchController = SearchViewController(searchResultsController: nil)

    // MRK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Tracks List"
        self.navigationItem.searchController = self.searchController
        self.searchController.searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tracks = self.getTracks()
            self.grouppedTracks()
            self.titles =  self.getHeaderTitles()
            self.tableView.reloadData()
            
        }
    }
    
    // MARK: OwnMethods
    func getTracks() -> [TrackObject] {
        var tempTracks: [TrackObject] = []
        if let logDictionary = UserDefaults.standard.value(forKey: "visitLOGSystem") as? [JSON] {
            logDictionary.forEach{
                let trackObject: TrackObject = TrackObject.init()
                trackObject.map(map: $0)
                tempTracks.append(trackObject)
                
            }
        }
        return tempTracks
        
    }
    
    func grouppedTracks() {
        var tempTracks: [TrackObject] = []
        let arrivedDates: [Double] = self.tracks.map({ $0.arrivalDate }).uniqueElements
        arrivedDates.forEach({ arrivalDate in
            let grouppedTracks: [TrackObject] = self.tracks.filter({ $0.arrivalDate == arrivalDate || abs($0.arrivalDate - arrivalDate) < 60 })
            if grouppedTracks.count > 1 {
                grouppedTracks[0].departurDate = grouppedTracks.last!.departurDate
                grouppedTracks[0].isComplete = true
                tempTracks.append(grouppedTracks[0])
                
            } else {
                tempTracks.append(grouppedTracks[0])
                
            }
        })
        self.tracks = tempTracks.sorted(by: { $0.arrivalDate > $1.arrivalDate })
        
    }
    
    func getHeaderTitles() -> [String] {
        self.tracks.forEach({
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
        case .original: return self.tracks.filter({ $0.dateNow!.contains(self.titles[section]) }).count
        case .filter: return self.filterTracks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackObject = self.tableDataSource == .filter ? self.filterTracks[indexPath.row] : self.tracks.filter({ $0.dateNow.contains(self.titles[indexPath.section])})[indexPath.row]
        return {
            let cell: TrackCellTableViewCell = UIView.fromNib()
            cell.set(trackObject)
            return cell
            
        }()
    }
    
}

// MARK :- UISearchBarDelegate
extension DetailLocationViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.setTableView(self.tracks.filter { $0.dateNow.contains(searchBar.text ?? "") })
    
    }
    
}
