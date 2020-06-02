//
//  LocationManager.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 30/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private let geocoder = CLGeocoder()
    
    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }
    
    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }
    
    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
    }
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    private func geocode() {
        guard let location = self.location else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        })
    }
    
    /*private func coordinates(address: String) {
        geocoder.geocodeAddressString(address, completionHandler: { (places, error) in
            if error == nil {
                self.placemarkCoordinates = places?[0].location
            } else {
                self.placemarkCoordinates = nil
            }
        })
    }*/
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.geocode()
    }
}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}
