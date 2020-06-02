//
//  MapViewOverlay.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 31/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct MapViewOverlay: View {

    @Binding var totalConfirmed: Int
    @Binding var totalDeaths: Int
    @Binding var totalRecovered: Int
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Infected: \(totalConfirmed)")
            Text("Cured: \(totalRecovered)")
            Text("Deaths: \(totalDeaths)")
        }
        .padding()
        .font(.headline)
        .foregroundColor(.primary)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct MapViewOverlay_Previews: PreviewProvider {
    static var previews: some View {
        //MapViewOverlay(placemarks: [Placemark.example])
        MapViewOverlay(totalConfirmed: .constant(1000),
                       totalDeaths: .constant(1),
                       totalRecovered: .constant(100))
        .previewLayout(.fixed(width: 350, height: 70))
    }
}
