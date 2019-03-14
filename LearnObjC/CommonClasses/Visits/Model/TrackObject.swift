//
//  TrackObject.swift
//  Socio MAS
//
//  Created by ARIEL DIAZ on 3/6/19.
//  Copyright © 2019 Diego Yael. All rights reserved.
//

import Foundation
import MapKit

@objc class TrackObject: BaseMap {
    
    // MARK: Attributes
    var arrivalDate: Double!
    var dateNow: String!
    var departurDate: Double!
    var latitude: Double!
    var longitude: Double!
    var annotation: MKPointAnnotation?
    var isComplete: Bool = false
    
    
    override func map(map: JSON) {
        self.arrivalDate <- map["arrivalDate"]
        self.dateNow <- map["dateNow"]
        self.departurDate <- map["departurDate"]
        self.latitude <- map["latitude"]
        self.longitude <- map["longitude"]
        self.annotation <- {
            let annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
            annotation.title = self.dateNow
            return annotation
            
        }()
    }
}
