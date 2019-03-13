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
    @IBOutlet weak var arrivedIndicator: UIView!
    @IBOutlet weak var departureIndicator: UIView!
    
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
        self.arrivedIndicator.makeViewWith(features: [.roundedView(.full, .clear), .bordered(.black, 1)])
        self.departureIndicator.makeViewWith(features: [.roundedView(.full, .clear), .bordered(.black, 1)])
        self.trackObject = trackObject
        let calendar = Calendar.current
        self.lblDateNow.text = "notified at: \(trackObject.dateNow!)"
            .replacingOccurrences(of: "Central Standard Time", with: "")
        let arriveDate: Date = Date(timeIntervalSince1970: trackObject.arrivalDate)
        self.lblArrive.text = "arrived at: \(calendar.component(.hour, from: arriveDate).zero()):\(calendar.component(.minute, from: arriveDate).zero()):\(calendar.component(.second, from: arriveDate).zero())"
        let departureDate: Date = Date(timeIntervalSince1970: trackObject.departurDate)
        self.lblDepartur.text = "departur at: \(calendar.component(.hour, from: departureDate).zero()):\(calendar.component(.minute, from: departureDate).zero()):\(calendar.component(.second, from: departureDate).zero())"
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

extension Int {
    func zero() -> String {
        return self == 0 ? "00" : (self < 10) ? "0\(self)" : "\(self)"
    }
}
