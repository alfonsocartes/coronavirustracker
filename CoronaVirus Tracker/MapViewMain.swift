//
//  MapViewMain.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 02/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI
import MapKit

struct MapViewMain: View {
    
    @Binding var placemarks: [Placemark]
    @Binding var totalConfirmed: Int
    @Binding var totalDeaths: Int
    @Binding var totalRecovered: Int
    
    @State private var annotations = [MKPointAnnotation]()
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var userCoordinate = CLLocationCoordinate2D()
    @State private var showingAlertLocationDenied = false
    @State private var satelliteView = false
    @State private var selectedAnnotation: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showRefreshAlert = false
    
    let locationManager = CLLocationManager()
    
    var body: some View {
        VStack {
            ViewNotAvailable(isShowing: (annotations.count < placemarks.count / 2), viewName: "Map") {
            //LoadingView(isShowing: self.$showingLoading) {
                ZStack {
                    MapViewMultiple(annotations: self.annotations,
                                    centerCoordinate: self.$centerCoordinate,
                                    userCoordinate: self.$userCoordinate,
                                    showingAlertLocationDenied: self.$showingAlertLocationDenied,
                                    satelliteView: self.$satelliteView,
                                    selectedAnnotation: self.$selectedAnnotation,
                                    showingPlaceDetails: self.$showingPlaceDetails)
                    .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                let lastUpdateOld = self.placemarks.first?.place.LastUpdate
                                self.placemarks = generatePlacemarks()
                                let lastUpdateNew = self.placemarks.first?.place.LastUpdate
                                if lastUpdateOld == lastUpdateNew {
                                    self.showRefreshAlert = true
                                }
                                /*if let firstPlacemarkCoordinate = self.annotations.first?.coordinate {
                                    self.centerCoordinate = firstPlacemarkCoordinate
                                }*/
                            }) {
                                Image(systemName: "arrow.2.circlepath")
                                    .padding()
                                    .font(.title)
                                    .background(Color.white.opacity(0.50))
                                    .clipShape(Circle())
                            }
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                self.satelliteView.toggle()
                            }) {
                                if self.satelliteView {
                                    Image(systemName: "map.fill")
                                        .padding()
                                        .font(.title)
                                        .background(Color.white.opacity(0.50))
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "map")
                                        .padding()
                                        .font(.title)
                                        .background(Color.white.opacity(0.50))
                                        .clipShape(Circle())
                                }
                            }
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                // center the map in the user's location
                                if let userLocation = self.getUserLocation() {
                                    self.userCoordinate = userLocation
                                    self.centerCoordinate = userLocation
                                }
                            }) {
                                Image(systemName: "location.fill")
                                    .padding(.top, 4)
                                    .padding(.trailing, 4)
                                    .padding()
                                    .font(.title)
                                    .background(Color.white.opacity(0.50))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.trailing)
                    VStack {
                        MapViewOverlay(totalConfirmed: self.$totalConfirmed,
                                       totalDeaths: self.$totalDeaths,
                                       totalRecovered: self.$totalRecovered)
                        Spacer()
                    }
                    .padding()
                }
            //}
        }
             BannerView()
        }
        .onAppear() {
            self.annotations = self.generateAnnotations()
        }
        .sheet(isPresented: $showingPlaceDetails) {
            if self.selectedAnnotation != nil {
                PlacemarkDetail(placemark: selectedPlacemark(annotation: self.selectedAnnotation!, placemarks: self.placemarks), fromList: false)
            }
        }
        .alert(isPresented: $showingAlertLocationDenied) {
            Alert(title: Text("Location Access Disabled"),
                  message: Text("In order to center the map on your location, please open this app's settings and set location access to 'While Using the App'."),
                  primaryButton: .default(Text("Cancel")),
                  secondaryButton: .default(Text("Open Settings")){
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })
        }
        .alert(isPresented: self.$showRefreshAlert) {
            Alert(title: Text("No updates avalable"),
                  message: Text("There are no updates avilable yet. Please stay tuned."))
        }
    }
    
    func generateAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation()]
        for placemark in self.placemarks {
            if placemark.coordinate.latitude != 0 && placemark.coordinate.latitude != 0 {
               let annotation = MKPointAnnotation()
               annotation.wrappedTitle = placemark.place.ProvinceState.isEmpty ? placemark.place.CountryRegion : placemark.place.ProvinceState
               annotation.wrappedSubtitle = String("People: \(placemark.place.Confirmed)")
               annotation.coordinate = placemark.coordinate
                print("Done: annotation: \(placemark.coordinate)")
                annotations.append(annotation)
                print("Done added annotation for: \(placemark.place.ProvinceState.isEmpty ? placemark.place.CountryRegion : placemark.place.ProvinceState)")
            } else {
                 print("Done ERROR annotation: \(placemark.coordinate)")
                print("Done ERROR not added annotation for: \(placemark.place.ProvinceState.isEmpty ? placemark.place.CountryRegion : placemark.place.ProvinceState)")
            }
            
        }
        print("Done generateAnnotations()")
        return annotations
    }
    
    func getUserLocation() -> CLLocationCoordinate2D? {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            let locations = [CLLocation]()
            return locationManager(locationManager, didUpdateLocations: locations)
        case .restricted,.denied:
            showingAlertLocationDenied = true
        default:
            showingAlertLocationDenied = true
        }
        return nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) -> CLLocationCoordinate2D {
        let locValue: CLLocationCoordinate2D = manager.location?.coordinate ?? CLLocationCoordinate2D()
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        return locValue
    }
}

struct MapViewMain_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMain(placemarks: .constant([Placemark.example1]),
                totalConfirmed: .constant(1000),
                totalDeaths: .constant(1),
                totalRecovered: .constant(100))
    }
}
