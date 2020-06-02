//
//  PlaceRowCountry.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 01/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct PlaceRowCountry: View {
    
    var place: Place
    
    var body: some View {
        HStack {
            EmojiFlagView(country: place.CountryRegion)
            .frame(width: 40, height: 40)
            Text(verbatim: place.CountryRegion)
                .fontWeight(.semibold)
            if (place.ProvinceState != "") {
                Text(verbatim: "(\(place.ProvinceState))")
                .fontWeight(.semibold)
            }
            Spacer()
            //Text(verbatim: "\(calculatetotalConfirmedCountryRegion(CountryRegion: place.CountryRegion))")
            Text(verbatim: "\(place.Confirmed)")
            .fontWeight(.semibold)
        }
    }
    
    func calculatetotalConfirmedCountryRegion(CountryRegion: String) -> Int {
        
        var totalConfirmedCountryRegion = 0
        
        for place in trackerData {
            if place.CountryRegion == CountryRegion {
                totalConfirmedCountryRegion += place.Confirmed
            }
        }
        
        return totalConfirmedCountryRegion
    }
}

struct PlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlaceRowCountry(place: trackerData[1])
            PlaceRowCountry(place: trackerData[30])
            PlaceRowCountry(place: trackerData[40])
        }
        //.environmentObject(Favorites())
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
