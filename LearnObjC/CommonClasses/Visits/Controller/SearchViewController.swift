//
//  SearchViewController.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 3/15/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import UIKit

class SearchViewController: UISearchController {

    // MARK :- Attributes
    var viewWorkSpace = UIView()
    var workSpaceFrame: CGRect!
    let statusBarFrame: CGRect = UIApplication.shared.statusBarFrame
    let animationTime: Double = 0.3
    var tableView: UITableView!
    var tracks: [TrackObject] = []
    
    // MARK :- Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.viewWorkSpace)
        self.viewWorkSpace.makeViewWith(features: [.color(UIColor.black.withAlphaComponent(0.7))])
        self.tableView = {
            let tableView = UITableView(frame: self.viewWorkSpace.bounds)
            tableView.delegate = self
            tableView.dataSource = self
            return tableView
            
        }()
        self.viewWorkSpace.addSubview(self.tableView)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        self.setLayout(true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.setTableView([])
        self.setLayout(false)
        
    }
    
    func setLayout(_ appear: Bool) {
        self.viewWorkSpace.frame = CGRect(
            x: 0,
            y: appear ? self.statusBarFrame.height + self.searchBar.frame.height : self.statusBarFrame.origin.y,
            width: self.view.frame.width,
            height: !appear ? self.view.frame.height - self.searchBar.frame.maxY : 0
        )
        UIView.animate(withDuration: self.animationTime, animations: {
            self.viewWorkSpace.alpha = appear ? 1 : 0
            self.viewWorkSpace.frame = CGRect(
                x: 0,
                y: appear ? self.statusBarFrame.height + self.searchBar.frame.height : self.statusBarFrame.origin.y,
                width: self.view.frame.width,
                height: appear ? self.view.frame.height - self.searchBar.frame.maxY : 0
            )
        })
    }
    
    func setTableView(_ tracks: [TrackObject]) {
        self.tracks = tracks
        UIView.animate(withDuration: self.animationTime, animations: {
            self.tableView.frame = !tracks.isEmpty ? self.viewWorkSpace.bounds : CGRect(origin: .zero, size: CGSize(width: self.viewWorkSpace.frame.width, height: 0))
        })
        self.tableView.reloadData()
        
    }
    
}

// MARK :- UITableviewDelegate & UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let track: TrackObject = self.tracks[indexPath.row]
        return {
            let cell: TrackCellTableViewCell = UIView.fromNib()
            cell.set(track)
            return cell
            
        }()
    }
    
}
