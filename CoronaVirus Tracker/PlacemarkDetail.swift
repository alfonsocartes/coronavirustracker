//
//  PlacemarkDetail.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 29/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI
import MapKit

struct PlacemarkDetail: View {
    
    var placemark: Placemark
    var fromList: Bool
    
    let randomImage = Int.random(in: 1 ..< imageData.count-1)
    var annotation = MKPointAnnotation()

    init(placemark: Placemark, fromList: Bool) {
        // I think that if it's declared with @State I don't have to inizialize it
        self.placemark = placemark
        
        self.annotation.wrappedTitle = placemark.place.ProvinceState.isEmpty ? placemark.place.CountryRegion : placemark.place.ProvinceState
        self.annotation.wrappedSubtitle = "\(placemark.place.Confirmed)"
        self.annotation.coordinate = placemark.coordinate
        
        self.fromList = fromList
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            if fromList {
                VStack {
                    GeometryReader { geometry in
                        ScrollView(.vertical) {
                            VStack {
                                ViewNotAvailable(isShowing: (self.annotation.coordinate.latitude == 0 && self.annotation.coordinate.longitude == 0), viewName: "Map") {
                                    MapViewDetail(annotations: [self.annotation])
                                }
                                        .offset(x: 0, y: -75)
                                        .padding(.bottom, -75)
                                        .edgesIgnoringSafeArea(.top)
                                        .frame(height: geometry.size.height / 2)
                                        .shadow(radius: 5)
                                    VStack {
                                        DescriptionView(placemark: self.placemark)
                                    }
                                    .offset(x: 0, y: -geometry.size.height / 6)
                                    .padding(.bottom, -geometry.size.height / 6)
                            }
                        }
                    }
                    BannerView()
                }
            } else {
                VStack {
                    HStack {
                        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                            Handle()
                        }
                        .padding()
                    }
                    GeometryReader { geometry in
                        ScrollView(.vertical) {
                            VStack {
                                DescriptionView(placemark: self.placemark)
                            }
                            .padding(.top, 25)
                        }
                    }
                    BannerView()
                }
            }
        }
        .navigationBarTitle(Text(verbatim: placemark.place.ProvinceState.isEmpty ? placemark.place.CountryRegion : placemark.place.ProvinceState), displayMode: .inline)
    }
}


struct PlacemarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlacemarkDetail(placemark: Placemark.example1,
                        fromList: true)
            PlacemarkDetail(placemark: Placemark.example1,
                        fromList: false)
        }
    }
}
