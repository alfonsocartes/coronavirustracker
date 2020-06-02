//
//  PlaceListCountries.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 01/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI
import MapKit

struct PlaceListCountries: View {
    
    @Binding var placemarks: [Placemark]
    
    @Binding var totalConfirmed: Int
    @Binding var totalDeaths: Int
    @Binding var totalRecovered: Int
    
    @State private var showingMapView = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            List {
                ForEach(placemarks, id: \.id) { placemark in
                    NavigationLink (destination: PlacemarkDetail(placemark: placemark, fromList: true)) {
                        PlaceRowCountry(place: placemark.place)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Countries"), displayMode: .large)
        .navigationBarItems(trailing:
            Button(action: {
                self.showingMapView = true
            }) {
                Image(systemName: "map")
                    .font(.headline)
        })
        .sheet(isPresented: $showingMapView) {
            VStack {
                HStack {
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                        Handle()
                    }
                    .padding()
                }
                MapViewMain(placemarks: self.$placemarks,
                            totalConfirmed: self.$totalConfirmed,
                            totalDeaths: self.$totalDeaths,
                            totalRecovered: self.$totalRecovered)
            }
        }
    }
}

struct PlaceList_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListCountries(placemarks: .constant([Placemark.example1]),
                           totalConfirmed: .constant(1000),
                           totalDeaths: .constant(1),
                           totalRecovered: .constant(100))
    }
}
