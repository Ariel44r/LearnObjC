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
        self.lblDateNow.text = "dateNow: \n\(trackObject.dateNow!)"
            .replacingOccurrences(of: "Central Standard Time", with: "")
        self.lblArrive.text = "arrived: \n\(Date(timeIntervalSince1970: trackObject.arrivalDate).description(with: .current))"
            .replacingOccurrences(of: "Central Standard Time", with: "")
        self.lblDepartur.text = "departur: \n\(Date(timeIntervalSince1970: trackObject.departurDate).description(with: .current))"
            .replacingOccurrences(of: "Central Standard Time", with: "")
        
    }
    
    func willAppear() {
        if let annotation = self.trackObject.annotation as MKPointAnnotation? {
            self.mapView.addAnnotation(annotation)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 500000), execute: {
                let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
                self.mapView.setRegion(region, animated: false)
                self.mapView.isUserInteractionEnabled = false
                
            })
        }
    }
    
}
