//
//  LocationService.swift
//  park.ly
//
//  Created by Terrell Robinson on 2/28/17.
//  Copyright © 2017 TKYO. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let instance = LocationService()
    
    var locationManager = CLLocationManager() // Helps us manage our location
    var currentLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 50 // Every 50 meters CoreLocation will trigger a location update
        self.locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.currentLocation = locationManager.location?.coordinate // This function saves our GPS coordinates to our very own currentLocation variable.
    }
    
}
