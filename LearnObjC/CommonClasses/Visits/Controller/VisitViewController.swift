//
//  SocioProRootViewController.swift
//  Socio MAS
//
//  Created by ARIEL DIAZ on 3/6/19.
//  Copyright © 2019 Diego Yael. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import UserNotifications

class VisitViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Attributes
    let locationManager = CLLocationManager()
    let keyLogsName: String = "visitLOGSystem"
    var tracks: [TrackObject] = []
    let defaultSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "MapView"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.goToDetail))
        self.locationManager.delegate = self
        self.mapView.delegate = self
        self.requestForNotifications()
        self.requestForEnableLocationServices()
        
        self.testLogs()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            self.btnCurrentLocation("")
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! DetailLocationViewController
        controller.tracks = self.tracks.sorted(by: { $0.arrivalDate > $1.arrivalDate })
        
    }
    
    @IBAction func btnCurrentLocation(_ sender: Any) {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            let region = MKCoordinateRegion(center: self.locationManager.location!.coordinate, span: self.defaultSpan)
            self.mapView.setRegion(region, animated: true)
            
        }
        if let sender = sender as? UIButton {
            UIView.animate(withDuration: 0.3, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                    
                })
            })
        }
    }
    
    @objc func goToDetail() {
        if self.tracks.isEmpty {
            AlertControllerManager.showAlert(controller: self, alertStyle: .alert, title: "No existen registros de visitas", message: "Aún no cuentas con datos de visitas", actions: nil)
            
        } else {
            self.performSegue(withIdentifier: "detailSegue", sender: self.tracks)

        }
    }
    
    func testLogs() {
        self.tracks = []
        if let logDictionary: [JSON] = UserDefaults.standard.value(forKey: self.keyLogsName) as? [JSON] {
            logDictionary.forEach{
                let trackObject: TrackObject = TrackObject.init()
                trackObject.map(map: $0)
                self.tracks.append(trackObject)
                self.mapView.addAnnotation(trackObject.annotation!)
                
            }
        }
    }
    
    // MARK: OwnMethods
    func requestForNotifications() {
        let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        
    }
    
    func requestForEnableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            debugPrint("Authorized status are: [\(CLLocationManager.authorizationStatus().rawValue)]")
            
        case .authorizedWhenInUse:
            self.locationManager.requestAlwaysAuthorization()
            
        case .authorizedAlways:
            self.mapView.showsUserLocation = true
            self.locationManager.startMonitoringVisits()
            
        }
    }

}

// MARK: CLLocationManagerDelegate
extension VisitViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.requestForEnableLocationServices()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        let log: JSON = [
            "arrivalDate": visit.arrivalDate.timeIntervalSince1970,
            "dateNow": Date().description(with: .autoupdatingCurrent),
            "latitude": visit.coordinate.latitude,
            "longitude": visit.coordinate.longitude,
            "departurDate": visit.departureDate.timeIntervalSince1970
            
        ]
        if var logDictionary: [JSON] = UserDefaults.standard.value(forKey: self.keyLogsName) as? [JSON] {
            logDictionary.append(log)
            UserDefaults.standard.set(logDictionary, forKey: self.keyLogsName)
            
        } else {
            UserDefaults.standard.set([log], forKey: self.keyLogsName)
            
        }
        let notification = UILocalNotification()
        notification.fireDate = Date(timeIntervalSinceNow: 5)
        notification.alertBody = log["dateNow"] as? String
        notification.alertAction = "OK"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = log
        UIApplication.shared.scheduleLocalNotification(notification)
        
    }
    
}

extension VisitViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
        } else {
            annotationView!.annotation = annotation
            
        }
        return annotationView
        
    }
    
}
