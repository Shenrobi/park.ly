//
//  ParkingSpot.swift
//  park.ly
//
//  Created by Terrell Robinson on 2/27/17.
//  Copyright © 2017 TKYO. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class ParkingSpot: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
    }
    
    var subtitle: String? {
        return locationName
    }
    
    
    func mapItem(location: CLLocationCoordinate2D) -> MKMapItem {
        
        let addressDictionary = [String(CNPostalAddressStreetKey): subtitle] // Dictionary that holds addresses
        let placemark = MKPlacemark(coordinate: location, addressDictionary: addressDictionary) // Takes a coordinate and an address dictionary and creates a specific point and connects it to a specific address
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title // Sets the value with the ParkingSpot's title property
        
        return mapItem
    }
    

}
