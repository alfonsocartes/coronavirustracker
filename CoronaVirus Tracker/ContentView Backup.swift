//
//  ContentView.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 29/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

/*import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var placemarks = generatePlacemarks()
    //@State var placemarks = [Placemark]()
    
    @State private var annotations = [MKPointAnnotation()]
    @State private var satelliteView = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var userCoordinate = CLLocationCoordinate2D()
    @State private var centerInUserCoordinate = false
    @State private var selectedAnnotation: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingAlertLocationDenied = false
    @State private var showingLoading = false
    @State private var showingMapView = false
    
    @State private var  totalConfirmed = 0
    @State private var totalDeaths = 0
    @State private var totalRecovered = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    
    //let locationManager = CLLocationManager()
    //The one in LocationManager.swift
    //@ObservedObject var lm = LocationManager()
    
    // TODO: this will be an environment object
    //var placemarks = generatePlacemarks()
    
    /*var country0: String  { return("\(placemarks[0].place.CountryRegion)") }
     var state0: String  { return("\(placemarks[0].place.ProvinceState)") }
     var latitude0: String  { return("\(placemarks[0].coordinate?.latitude)") }
     var longitude0: String  { return("\(placemarks[0].coordinate?.longitude)") }
     
     var country1: String  { return("\(placemarks[1].place.CountryRegion)") }
     var state1: String  { return("\(placemarks[1].place.ProvinceState)") }
     var latitude1: String  { return("\(placemarks[1].coordinate?.latitude)") }
     var longitude1: String  { return("\(placemarks[1].coordinate?.longitude)") }
     
     var country2: String  { return("\(placemarks[2].place.CountryRegion)") }
     var state2: String  { return("\(placemarks[2].place.ProvinceState)") }
     var latitude2: String  { return("\(placemarks[2].coordinate?.latitude)") }
     var longitude2: String  { return("\(placemarks[2].coordinate?.longitude)") }
     
     
     //Test values
     @ObservedObject var placemark = Placemark(place: trackerData[2])
     
     var country: String  { return("\(placemark.place.CountryRegion ?? "Unknown Country")") }
     var latitude: String  { return("\(placemark.coordinate?.latitude ?? 0)") }
     var longitude: String { return("\(placemark.coordinate?.longitude ?? 0)") }*/
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    StatsView(placemarks: $placemarks,
                              totalConfirmed: $totalConfirmed,
                              totalDeaths: $totalDeaths,
                              totalRecovered: $totalRecovered)
                }
                
                .navigationBarTitle(Text("Coronavirus Tracker"), displayMode: .large)
                .onAppear() {
                    //self.placemarks = generatePlacemarks()
                    //self.annotations = generateAnnotations(placemarks: self.placemarks)
                    self.generateTotals()
                }
                //Placemark test values:
                /*VStack {
                 Spacer()
                 VStack {
                 Text("Country: \(self.country)")
                 Text("Latitude: \(self.latitude)")
                 Text("Longitude: \(self.longitude)")
                 }
                 Spacer()
                 VStack {
                 Text("Country0: \(self.country0)")
                 Text("State0: \(self.state0)")
                 Text("Latitude0: \(self.latitude0)")
                 Text("Longitude0: \(self.longitude0)")
                 }
                 Spacer()
                 VStack {
                 Text("Country1: \(self.country1)")
                 Text("State1: \(self.state1)")
                 Text("Latitude1: \(self.latitude1)")
                 Text("Longitude1: \(self.longitude1)")
                 }
                 Spacer()
                 VStack {
                 Text("Country2: \(self.country2)")
                 Text("State2: \(self.state2)")
                 Text("Latitude2: \(self.latitude2)")
                 Text("Longitude2: \(self.longitude2)")
                 }
                 Spacer()
                 }*/
            }
            .tabItem {
                Image(systemName: "staroflife.fill")
                Text("Virus")
            }
            NavigationView {
                PlaceListCountries(placemarks: self.$placemarks,
                                totalConfirmed: self.$totalConfirmed,
                                totalDeaths: self.$totalDeaths,
                                totalRecovered: self.$totalRecovered)
            }
            .tabItem {
                Image(systemName: "list.dash")
                Text("Countries")
            }
        }
        .environment(\.horizontalSizeClass, .compact)
    }
    
    func generateTotals() {
        for placemark in trackerData {
            //print(self.totalConfirmed)
            //print(placemark.Confirmed)
            self.totalConfirmed += placemark.Confirmed
            //print(self.totalConfirmed)
            self.totalRecovered += placemark.Recovered
            self.totalDeaths += placemark.Deaths
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
}*/
