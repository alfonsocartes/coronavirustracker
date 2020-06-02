//
//  MapViewDetail.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 02/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI
import MapKit

struct MapViewDetail: UIViewRepresentable {
    
    var annotations: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
        if let coordinate = annotations.first?.coordinate {
            centerMap(mapView: mapView, coordinate: coordinate)
        }
    }
    
    func centerMap(mapView: MKMapView, coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewDetail

        init(_ parent: MapViewDetail) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            //parent.centerCoordinate = mapView.centerCoordinate
        }
    }
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


struct MapViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        MapViewDetail(annotations: [MKPointAnnotation.example])
    }
}
