//
//  DescriptionView.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 01/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct DescriptionView: View {
    
    var placemark: Placemark
    
    @State private var showPopUp = false
    @State private var randomImage = Int.random(in: 1 ..< imageData.count-1)
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack {
            Button(action: {
                self.showPopUp = true
            }) {
                CircleImage(image: Image(imageData[self.randomImage].imageName))
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
                //.padding(.top, geometry.size.height / 10)
                .accessibility(hidden: true)
            VStack {
                Spacer()
                //VStack {
                Text(self.placemark.place.ProvinceState)
                    .font(.largeTitle)
                Spacer()
                EmojiFlagView(country: self.placemark.place.CountryRegion)
                Text(self.placemark.place.CountryRegion)
                    .font(.title)
                //}
                Spacer()
                //if (self.placemark.place.annotation.coordinate.latitude != 0) {
                /*MapView(placemarks: .constant([self.placemark]),
                 annotations: .constant([self.placemark.place.annotation]),
                 satelliteView: .constant(false),
                 centerCoordinate: .constant(self.placemark.place.annotation.coordinate),
                 userCoordinate: .constant(self.placemark.place.annotation.coordinate),
                 centerInUserCoordinate: .constant(false),
                 selectedAnnotation: .constant(self.placemark.place.annotation),
                 showingPlaceDetails: .constant(false),
                 showingAlertLocationDenied: .constant(false),
                 showingLoading: .constant(false))
                 //.offset(x: 0, y: -75)
                 //.padding(.bottom, -75)
                 //.edgesIgnoringSafeArea(.top)
                 .frame(height: geometry.size.width / 2)
                 .shadow(radius: 5)
                 .padding()
                 // }*/
                
                VStack (alignment: .leading) {
                    Text("Infected: \(self.placemark.place.Confirmed)")
                    Text("Cured: \(self.placemark.place.Recovered)")
                    Text("Deaths: \(self.placemark.place.Deaths)")
                }
                .font(.title)
                .padding()
                Spacer()
                Text("Last update: \(self.placemark.place.LastUpdate)")
                    .font(.caption)
                Spacer()
            }
        }
        .padding()
            //.frame(width: geometry.size.width, height: geometry.size.height)
            
            .sheet(isPresented: $showPopUp) {
                VStack {
                    HStack {
                        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                            Handle()
                        }
                        .padding()
                    }
                    ImagePopUpView(image: Image(imageData[self.randomImage].imageName),
                                   imageCredits: imageData[self.randomImage].imageCredits,
                                   imageURL: imageData[self.randomImage].imageURL)
                    
                }
        }
    }
    
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(placemark: Placemark.example1)
    }
}
