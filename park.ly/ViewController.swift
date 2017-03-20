//
//  ViewController.swift
//  park.ly
//
//  Created by Terrell Robinson on 2/27/17.
//  Copyright © 2017 TKYO. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var parkButton: RoundButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Properties
    
    var parkedCarAnnotation: ParkingSpot?
    var regionRadius: CLLocationDistance = 500
    
    // MARK: Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self // MapView sends messages to its delegate regarding the loading of map data and changes in the potion of the map being displayed
        checkLocationAuthorizationStatus()
        
    }
    
    // MARK: IBAction

    @IBAction func parkButtonWasPressed(_ sender: Any) {
        
        let location = LocationService.instance.locationManager.location!
        
        if mapView.annotations.count == 1 {
            mapView.addAnnotation(parkedCarAnnotation!)
            parkButton.setImage(UIImage(named: "foundCar.png"), for: .normal)
        } else {
            mapView.removeAnnotations(mapView.annotations)
            parkButton.setImage(UIImage(named: "parkCar.png"), for: .normal)
        }
        
        centerMapOnLocation(location: location)
        
    }
    
    // MARK: Helper Methods
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            LocationService.instance.locationManager.delegate = self
            LocationService.instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationService.instance.locationManager.startUpdatingLocation()
        } else {
            LocationService.instance.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

extension ViewController: MKMapViewDelegate {
    
    // 1. We use an if let to create an annotation but only if it is of type ParkingSpot
    // 2. We set up an identifier ("pin")
    // 3. We create a variable type of MKPinAnnotationView
    // 4. Proceed to set various settings and customizations for the pin.
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ParkingSpot {
            let identifier = "pin"
            var view: MKPinAnnotationView
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.animatesDrop = true
            view.pinTintColor = UIColor.orange
            view.calloutOffset = CGPoint(x: -8, y: -3)
            view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIView
            return view
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! ParkingSpot
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        location.mapItem(location: (parkedCarAnnotation?.coordinate)!).openInMaps(launchOptions: launchOptions)
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    
    // 1. Every time our location updates, the map will now center on our location
    // 2. We create a constant to set our LocationService singleton which is persistently managing our location and updating the currentLocation value with our current GPS coordinates
    // 3. We set the value of the parkedCarAnnotation to be of type ParkingSpot
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        centerMapOnLocation(location: CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude))
        
        let locationServiceCoordinate = LocationService.instance.locationManager.location!.coordinate
        
        parkedCarAnnotation = ParkingSpot(title: "My Parking Spot", locationName: "Tap the 'i' for GPS", coordinate: CLLocationCoordinate2D(latitude: locationServiceCoordinate.latitude, longitude: locationServiceCoordinate.longitude))
        
    }
    
}




