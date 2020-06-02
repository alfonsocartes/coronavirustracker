//
//  MapViewMultiple.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 02/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI
import MapKit

struct MapViewMultiple: UIViewRepresentable {
    
    var annotations: [MKPointAnnotation]
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var userCoordinate: CLLocationCoordinate2D
    @Binding var showingAlertLocationDenied: Bool
    @Binding var satelliteView: Bool
    @Binding var selectedAnnotation: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        centerMap(mapView: mapView, coordinate: centerCoordinate)
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        
        if (mapView.mapType == MKMapType.standard && satelliteView) {
            mapView.mapType = MKMapType.hybrid
        }
        
        if (mapView.mapType == MKMapType.hybrid && !satelliteView) {
            mapView.mapType = MKMapType.standard
        }
        
        if annotations.count > 1 && annotations.count != mapView.annotations.count {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(annotations)
            if let coordinate = annotations.first?.coordinate {
                centerMap(mapView: mapView, coordinate: coordinate)
            }
        } else {
           // Should disable map
        }
        
        let centerInUserCoordinate =
            centerCoordinate.latitude != 0 &&
                centerCoordinate.longitude != 0 &&
                centerCoordinate.latitude == userCoordinate.latitude &&
                centerCoordinate.longitude == userCoordinate.longitude
        
        if centerInUserCoordinate {
            centerMap(mapView: mapView, coordinate: userCoordinate)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    
    // Coordinator
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewMultiple

        init(_ parent: MapViewMultiple) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            //parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                return nil
            }
            
            // this is our unique identifier for view reuse
            let identifier = "Placemark"
            
            // attempt to find a cell we can recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                // we didn't find one; make a new one
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                //let annotationLandmark = parent.annotationLandmark(annotation: annotation)
                
                //annotationView?.image = UIImage(systemName: "\(annotationLandmark.order).circle.fill")
                
                // allow this to show pop up information
                annotationView?.canShowCallout = true
                
                // attach an information button to the view
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                // we have a view to reuse, so give it the new annotation
                annotationView?.annotation = annotation
            }
            
            // whether it's a new view or a recycled one, send it back
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placemark = view.annotation as? MKPointAnnotation else { return }
            parent.selectedAnnotation = placemark
            parent.showingPlaceDetails = true
        }
    }
    
    
    // Supporting functions
    
    func centerMap(mapView: MKMapView, coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 75, longitudeDelta: 75)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

func selectedPlacemark(annotation: MKPointAnnotation, placemarks: [Placemark]) -> Placemark {
    var selectedPlace = placemarks[0]
    
    for placemark in placemarks {
        if (placemark.coordinate.latitude == annotation.coordinate.latitude) &&
            (placemark.coordinate.longitude == annotation.coordinate.longitude) {
            selectedPlace = placemark
        }
    }
    
    print("Selected place \(selectedPlace.place.ProvinceState.isEmpty ? selectedPlace.place.CountryRegion : selectedPlace.place.ProvinceState)")
    return selectedPlace
}

struct MapViewMultiple_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMultiple(annotations: [MKPointAnnotation.example],
                        centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
                        userCoordinate: .constant(MKPointAnnotation.example.coordinate),
                        showingAlertLocationDenied: .constant(false),
                        satelliteView: .constant(false),
                        selectedAnnotation: .constant(MKPointAnnotation.example),
                        showingPlaceDetails: .constant(false))
    }
}
