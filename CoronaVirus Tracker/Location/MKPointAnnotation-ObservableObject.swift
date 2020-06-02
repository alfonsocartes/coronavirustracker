//
//  MKPointAnnotation-ObservableObject.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 30/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
