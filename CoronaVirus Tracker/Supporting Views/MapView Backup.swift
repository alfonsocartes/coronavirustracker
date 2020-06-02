//
//  MapView.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 29/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

/*import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    //let locationManager = CLLocationManager()
    @ObservedObject var locationManager = LocationManager()
    
    //var placemarks: [Placemark]
    @Binding var placemarks: [Placemark]
    @Binding var annotations: [MKPointAnnotation]
    @Binding var satelliteView: Bool
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var userCoordinate: CLLocationCoordinate2D
    @Binding var centerInUserCoordinate: Bool
    @Binding var selectedAnnotation: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingAlertLocationDenied: Bool
    @Binding var showingLoading: Bool
    
    //TODO: ESTO ESTÁ FATAL PORQUE LLAMA A generatePlacemarks OTRA VEZ
    //var annotations = generateAnnotations(placemarks: generatePlacemarks())
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        if placemarks.count > 0 {
            if mapView.annotations.count < placemarks.count {
                print("MapView annotations: \(mapView.annotations.count)")
                print("placemarks.count: \(placemarks.count)")
                let annotationsInside = generateAnnotations(placemarks: placemarks)
                mapView.removeAnnotations(mapView.annotations)
                mapView.addAnnotations(annotationsInside)
            }
        }
         //annotations = generateAnnotations(placemarks: placemarks)
        centerMap(mapView: mapView, coordinate: mapView.annotations.first?.coordinate ?? centerCoordinate)
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
        if (mapView.mapType == MKMapType.standard && satelliteView) {
            mapView.mapType = MKMapType.hybrid
        }
        
        if (mapView.mapType == MKMapType.hybrid && !satelliteView) {
            mapView.mapType = MKMapType.standard
        }
        
        //if mapView.annotations.count == 0 {
        /*mapView.removeAnnotations(mapView.annotations)
        var annotations = [MKPointAnnotation()]
        for placemark in placemarks {
            let annotation = MKPointAnnotation()
            if let coordinate = placemark.coordinate {
                //annotation = placemark.place.annotation
                annotation.wrappedTitle = placemark.place.ProvinceState.isEmpty ? placemark.place.CountryRegion : placemark.place.ProvinceState
                annotation.wrappedSubtitle = String("People: \(placemark.place.Confirmed)")
                annotation.coordinate = coordinate
            }
            annotations.append(annotation)
            //print(annotation.coordinate)
        }
        mapView.addAnnotations(annotations)*/
        //}
        
        //TODO: Al iniciarse por primera vez entra aqui sin haber generado los Placemarks en ContentView
        /*if mapView.annotations.count <= 1 {
            generateAnnotations()
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(annotations)
        }*/
        /*var annotationsInside = generateAnnotations()
        if placemarks.count > 0 && annotationsInside.count > 1 {
            while annotationsInside.count < placemarks.count {
                annotationsInside = generateAnnotations()
            }
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(annotationsInside)
        }
        correctPlacemarks()*/
        
        if placemarks.count > 0 {
            //if mapView.annotations.count < placemarks.count {
                print("Done: MapView annotations: \(mapView.annotations.count)")
                print("Done: placemarks.count: \(placemarks.count)")
                let annotationsInside = generateAnnotations(placemarks: placemarks)
                print("Done: annotationsInside.count: \(annotationsInside.count)")
                mapView.removeAnnotations(mapView.annotations)
                mapView.addAnnotations(annotationsInside)
                centerMap(mapView: mapView, coordinate: mapView.annotations.first?.coordinate ?? centerCoordinate)
           // }
        } else {
            placemarks = generatePlacemarks()
            print("placemarks.count: \(placemarks.count)")
        }
        
        if selectedAnnotation != nil {
            centerMap(mapView: mapView, coordinate: selectedAnnotation!.coordinate)
            //centerCoordinate = selectedAnnotation!.coordinate
        }
        
        let centerNotZero =
        centerCoordinate.latitude != 0 &&
            centerCoordinate.longitude != 0
        
        if centerNotZero {
            centerMap(mapView: mapView, coordinate: centerCoordinate)
        }
        
        /*if annotations.count > 0 && selectedAnnotation == nil {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(annotations)
            centerMap(mapView: mapView, coordinate: annotations.first!.coordinate)
        }*/
        
        let centerInUserCoordinate =
            centerCoordinate.latitude != 0 &&
                centerCoordinate.longitude != 0 &&
                centerCoordinate.latitude == userCoordinate.latitude &&
                centerCoordinate.longitude == userCoordinate.longitude
        
        if centerInUserCoordinate {
            centerMap(mapView: mapView, coordinate: userCoordinate)
        }
    }
    
    func centerMap(mapView: MKMapView, coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 75, longitudeDelta: 75)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
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
    
    func generateAnnotations(placemarks: [Placemark]) -> [MKPointAnnotation]{
        
        var annotations = [MKPointAnnotation()]
            for placemark in placemarks {
                let annotation = MKPointAnnotation()
                if let coordinate = placemark.coordinate {
                    if coordinate.latitude == 0 && coordinate.longitude == 0 {
                        print("Error in placemark: \(placemark.place.ProvinceState.isEmpty ? placemark.place.CountryRegion : placemark.place.ProvinceState)")
                        print("Generating coordinates again")
                        print("Done?")
                        
                    } else {
                        annotation.wrappedTitle = placemark.place.ProvinceState.isEmpty ? placemark.place.CountryRegion : placemark.place.ProvinceState
                        annotation.wrappedSubtitle = String("People: \(placemark.place.Confirmed)")
                        annotation.coordinate = coordinate
                        annotations.append(annotation)
                    }
                }
        }
        print("Done generateAnnotations()")
        return annotations
    }
}

// MAP VIEW DATA FUNCTIONS:

func selectedPlacemark(annotation: MKPointAnnotation, placemarks: [Placemark]) -> Placemark {
    var selectedPlace = placemarks[0]
    
    for placemark in placemarks {
        if (placemark.coordinate?.latitude == annotation.coordinate.latitude) &&
            (placemark.coordinate?.longitude == annotation.coordinate.longitude) {
            selectedPlace = placemark
        }
    }
    
    print("Selected place \(selectedPlace.place.ProvinceState.isEmpty ? selectedPlace.place.CountryRegion : selectedPlace.place.ProvinceState)")
    return selectedPlace
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

#if DEBUG
struct MapView_Previews : PreviewProvider {
    static var previews: some View {
        MapView(placemarks: .constant([Placemark.example]),
                annotations: .constant([MKPointAnnotation.example]),
                satelliteView: .constant(false),
                centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
                userCoordinate: .constant(MKPointAnnotation.example.coordinate),
                centerInUserCoordinate: .constant(false),
                selectedAnnotation: .constant(MKPointAnnotation.example),
                showingPlaceDetails: .constant(false),
                showingAlertLocationDenied: .constant(false),
                showingLoading: .constant(false))
       /* MapView(placemarks: [Placemark.example],
                satelliteView: .constant(false),
                centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
                userCoordinate: .constant(MKPointAnnotation.example.coordinate),
                centerInUserCoordinate: .constant(false),
                selectedAnnotation: .constant(MKPointAnnotation.example),
                showingPlaceDetails: .constant(false),
                showingAlertLocationDenied: .constant(false))*/
    }
}
#endif*/
