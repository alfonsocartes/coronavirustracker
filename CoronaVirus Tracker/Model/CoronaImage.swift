//
//  CoronaImage.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 01/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import Foundation

let imageData: [CoronaImage] = load("images.json")

struct CoronaImage: Hashable, Codable {
    var imageName: String
    var imageCredits: String
    var imageURL: String
}
