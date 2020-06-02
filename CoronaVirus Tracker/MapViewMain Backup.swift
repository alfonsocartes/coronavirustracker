//
//  MapViewMain.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 01/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

/*import SwiftUI
import MapKit

struct MapViewMain: View {
    
    //var placemarks: [Placemark]
    @Binding var placemarks: [Placemark]
    
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
    
    /*@Binding var annotations: [MKPointAnnotation]
    @Binding var satelliteView: Bool
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var userCoordinate: CLLocationCoordinate2D
    @Binding var centerInUserCoordinate: Bool
    @Binding var selectedAnnotation: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingAlertLocationDenied: Bool
    @Binding var showingLoading: Bool*/
    
    @Binding var totalConfirmed: Int
    @Binding var totalDeaths: Int
    @Binding var totalRecovered: Int
    
    let locationManager = CLLocationManager()
    
    var body: some View {
        //ViewNotAvailable(isShowing: (annotations.count < placemarks.count / 2), viewName: "Map") {
            LoadingView(isShowing: self.$showingLoading) {
                ZStack {
                    MapView(placemarks: self.$placemarks,
                            annotations: self.$annotations,
                            satelliteView: self.$satelliteView,
                            centerCoordinate: self.$centerCoordinate,
                            userCoordinate: self.$userCoordinate,
                            centerInUserCoordinate: self.$centerInUserCoordinate,
                            selectedAnnotation: self.$selectedAnnotation,
                            showingPlaceDetails: self.$showingPlaceDetails,
                            showingAlertLocationDenied: self.$showingAlertLocationDenied,
                            showingLoading: self.$showingLoading)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                if let firstPlacemarkLocation = self.placemarks.first?.coordinate {
                                    self.centerCoordinate = firstPlacemarkLocation
                                }
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
                        //MapViewOverlay(placemarks: placemarks)
                        MapViewOverlay(totalConfirmed: self.$totalConfirmed,
                                       totalDeaths: self.$totalDeaths,
                                       totalRecovered: self.$totalRecovered)
                        Spacer()
                    }
                    .padding()
                }
            }
        //}
        .sheet(isPresented: $showingPlaceDetails) {
            if self.selectedAnnotation != nil {
                PlaceDetail(placemark: selectedPlacemark(annotation: self.selectedAnnotation!, placemarks: self.placemarks), fromList: false)
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
        MapViewMain(placemarks: .constant([Placemark.example]),
                totalConfirmed: .constant(1000),
                totalDeaths: .constant(1),
                totalRecovered: .constant(100))
    }
}*/
