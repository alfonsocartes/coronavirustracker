//
//  Tracker.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 29/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI
import MapKit

struct Place: Hashable, Codable {
    var ProvinceState: String
    var CountryRegion: String
    var LastUpdate: String
    var Confirmed: Int
    var Deaths: Int
    var Recovered: Int 
}

extension Place {
    static var example1: Place {
        return Place(ProvinceState: "Athens",
                     CountryRegion: "Greece",
                     LastUpdate: "2/1/2020 10:00",
                     Confirmed: 10,
                     Deaths: 1,
                     Recovered: 2)
    }
    
    static var example2: Place {
        return Place(ProvinceState: "",
                     CountryRegion: "Italy",
                     LastUpdate: "2/1/2020 10:00",
                     Confirmed: 100,
                     Deaths: 10,
                     Recovered: 20)
    }
    
    static var example3: Place {
        return Place(ProvinceState: "",
                     CountryRegion: "Serbia",
                     LastUpdate: "2/1/2020 10:00",
                     Confirmed: 1000,
                     Deaths: 100,
                     Recovered: 200)
    }
}




/*extension Place {
    private static var _myComputedProperty = MKPointAnnotation()
    
    var annotation:MKPointAnnotation {
        get {
            return Place._myComputedProperty
        }
        set(newValue) {
            Place._myComputedProperty = newValue
        }
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
*/


