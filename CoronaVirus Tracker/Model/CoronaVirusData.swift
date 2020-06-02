//
//  CoronaVirusData.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 29/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import UIKit
import SwiftUI


// Cool documentation: https://www.hackingwithswift.com/books/ios-swiftui/using-generics-to-load-any-kind-of-codable-data

let urlString = "http://fontravels.com/alfonso/csvjsononline"


// Testing file:
//let trackerData: [Place] = load("csvjson.json")
//Production file:
let trackerData: [Place] = loadURL(urlString)

func loadURL<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    var data: Data
    
    
    guard let url = URL(string: "\(filename).json") else {
         fatalError("Couldn't find file in \(filename).")
    }
    print("url = \(url)")
    
    do {
        data = try Data(contentsOf: url)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}



final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(verbatim: name))
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}
