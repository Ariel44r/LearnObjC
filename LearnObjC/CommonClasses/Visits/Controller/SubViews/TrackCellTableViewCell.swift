//
//  TrackCellTableViewCell.swift
//  Socio MAS
//
//  Created by ARIEL DIAZ on 3/10/19.
//  Copyright © 2019 Diego Yael. All rights reserved.
//

import UIKit
import MapKit

class TrackCellTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var lblDateNow: UILabel!
    @IBOutlet weak var lblArrive: UILabel!
    @IBOutlet weak var lblDepartur: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Attributes
    var trackObject: TrackObject!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ trackObject: TrackObject) {
        self.trackObject = trackObject
        let calendar = Calendar.current
        self.lblDateNow.text = "dateNow: \n\(trackObject.dateNow!)"
            .replacingOccurrences(of: "Central Standard Time", with: "")
        let arriveDate: Date = Date(timeIntervalSince1970: trackObject.arrivalDate)
        self.lblArrive.text = "arrived at: \n\(calendar.component(.hour, from: arriveDate)) : \(calendar.component(.minute, from: arriveDate)) : \(calendar.component(.second, from: arriveDate))"
        let departureDate: Date = Date(timeIntervalSince1970: trackObject.departurDate)
        self.lblDepartur.text = "departur at: \n\(calendar.component(.hour, from: departureDate)) : \(calendar.component(.minute, from: departureDate)) : \(calendar.component(.second, from: departureDate))"
        self.willAppear()
        
    }
    
    func willAppear() {
        if let annotation = self.trackObject.annotation as MKPointAnnotation? {
            self.mapView.addAnnotation(annotation)
            let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
            let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
            self.mapView.setRegion(region, animated: false)
            self.mapView.isUserInteractionEnabled = false
            
        }
    }
    
}
