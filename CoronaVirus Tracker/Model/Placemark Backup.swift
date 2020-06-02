//
//  Placemark.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 30/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

/*
import SwiftUI
import Foundation
import CoreLocation
import Combine


class Placemark:ObservableObject {
     // Places + coordinates
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private let geocoder = CLGeocoder()
    
    /*@Published var place: Place? {
        willSet { objectWillChange.send() }
    }*/
    var place: Place
    
    @Published var coordinate: CLLocationCoordinate2D? {
        willSet { objectWillChange.send() }
    }
    
    @Published var showingLoading: Bool {
        willSet { objectWillChange.send() }
    }
    
    init(place: Place) {
        self.place = place
        self.showingLoading = true
        let address = self.place.ProvinceState.isEmpty ? self.place.CountryRegion : self.place.ProvinceState
        getCoordinate(addressString: address) { (responseCoordinate, error) in
             if error == nil {
                self.objectWillChange.send()
                self.coordinate = responseCoordinate
                self.place.annotation.coordinate = responseCoordinate
                print("Done? \(self.place.ProvinceState.isEmpty ? self.place.CountryRegion : self.place.ProvinceState)")
                self.showingLoading = false
           }
        }
    }
    
    func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}

extension Placemark {
    static var example: Placemark {
        let place = Place(ProvinceState: "London",
                          CountryRegion: "United Kingdom",
                          LastUpdate: "1/30/2020 21:30",
                          Confirmed: 100,
                          Deaths: 1,
                          Recovered: 10)
        return Placemark(place: place)
    }
}


/*class Placemark: ObservableObject {
    
    // Places + coordinates
    
    @Published var place: Place
    @Published var coordinate: CLLocationCoordinate2D
    
    private let geocoder = CLGeocoder()
    
    init() {
        self.place = Place()
        self.coordinate = CLLocationCoordinate2D()
        calculateCoordinates()
    }
    
    /*func add(_ place: Place) {
        objectWillChange.send()
        calculateCoordinates(place)
    }*/
    
    private func calculateCoordinates() {
        objectWillChange.send()
        let address = self.place.ProvinceState.isEmpty ? self.place.CountryRegion : self.place.ProvinceState
        geocoder.geocodeAddressString(address, completionHandler: { (places, error) in
            if error == nil {
                if let coordinate = places?[0].location?.coordinate {
                    self.place.annotation.coordinate = coordinate
                }
            } else {
                //self.placemarks.append(place)
            }
        })
    }
    
   /* private func calculateCoordinates() {
        for place in trackerData {
            let address = place.ProvinceState.isEmpty ? place.CountryRegion : place.ProvinceState
            geocoder.geocodeAddressString(address, completionHandler: { (places, error) in
                if error == nil {
                    if let coordinate = places?[0].location?.coordinate {
                        place.annotation.coordinate = coordinate
                    }
                    self.placemarks.append(place)
                } else {
                    self.placemarks.append(place)
                }
            })
        }
    }*/
}*/
 */
