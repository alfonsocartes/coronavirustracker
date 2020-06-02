//
//  ContentView.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 02/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    // TODO: Since all of these variables are used in different views they should be enviroment objects?
    @State private var placemarks = generatePlacemarks()
    @State private var totalConfirmed = 0
    @State private var totalDeaths = 0
    @State private var totalRecovered = 0
    @State private var showingNoDataAlert = trackerData.count == 0
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack {
            TabView {
                NavigationView {
                    VStack {
                        StatsView(placemarks: $placemarks,
                                  totalConfirmed: $totalConfirmed,
                                  totalDeaths: $totalDeaths,
                                  totalRecovered: $totalRecovered)
                    }
                    .navigationBarTitle(Text("CoronaVirus Tracker"), displayMode: .large)
                }
                .tabItem {
                    Image(systemName: "staroflife.fill")
                    Text("Virus")
                }
                VStack {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        NavigationView {
                            VStack {
                                PlaceListCountries(placemarks: self.$placemarks,
                                                   totalConfirmed: self.$totalConfirmed,
                                                   totalDeaths: self.$totalDeaths,
                                                   totalRecovered: self.$totalRecovered)
                                BannerView()
                            }
                        }
                    } else {
                        NavigationView {
                            PlaceListCountries(placemarks: self.$placemarks,
                                               totalConfirmed: self.$totalConfirmed,
                                               totalDeaths: self.$totalDeaths,
                                               totalRecovered: self.$totalRecovered)
                            StatsView(placemarks: self.$placemarks,
                                      totalConfirmed: self.$totalConfirmed,
                                      totalDeaths: self.$totalDeaths,
                                      totalRecovered: self.$totalRecovered)
                        }
                        .environment(\.horizontalSizeClass, .regular)
                    }
                }
                .tabItem {
                    Image(systemName: "globe")
                    Text("Countries")
                }
            }
            .onAppear() {
                self.generateTotals()
            }
            .environment(\.horizontalSizeClass, .compact)
        }
        .alert(isPresented: self.$showingNoDataAlert) {
            Alert(title: Text("No data avalable"),
                  message: Text("There is no data avilable yet. Please stay tuned."))
        }
    }
    
    func generateTotals() {
        if (self.totalConfirmed + self.totalRecovered + self.totalDeaths) == 0 {
            for placemark in trackerData {
                self.totalConfirmed += placemark.Confirmed
                self.totalRecovered += placemark.Recovered
                self.totalDeaths += placemark.Deaths
            }
        }
    }
}

func generatePlacemarks() -> [Placemark] {
    var placemarks = [Placemark]()
    for place in trackerData {
        let placemark = Placemark(place: place)
        placemarks.append(placemark)
    }
    print("Done generatePlacemarks()")
    return placemarks
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
