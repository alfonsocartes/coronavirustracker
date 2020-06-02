//
//  Placemark.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 02/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI
import MapKit

class Placemark: ObservableObject {
    
    var id = UUID()
    var place: Place
    
    @Published var coordinate = CLLocationCoordinate2D()
    
    init(place: Place) {
        self.place = place
        let address = "\(self.place.CountryRegion) \(self.place.ProvinceState)"
        getCoordinate(addressString: address) { (responseCoordinate, error) in
            if error == nil {
                self.coordinate = responseCoordinate
                print("Done placemark coordinates for: \(address)")
            } else {
                print("Error, not done placemark coordinates for: \(address)")
                print("TODO: inform generatePlacemarks() or generateAnnotations() that it could not be completed (Done)")
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
    static var example1: Placemark {
        Placemark(place: Place.example1)
    }
    static var example2: Placemark {
        Placemark(place: Place.example2)
    }
    static var example3: Placemark {
        Placemark(place: Place.example3)
    }
}
