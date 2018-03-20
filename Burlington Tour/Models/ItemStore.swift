//
//  ItemsStore.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/19/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import Foundation

class ItemStore {
    var places: [Place] = []
    
    init() {
        loadPlaces()
    }
    
    func loadPlaces() {
        var place : Place
        if let path = Bundle.main.path(forResource: "Places", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for item in 0..<Array(dict).count {
                    if let p = dict[String(item)] as? [String:AnyObject],
                        let title = p["title"] as? String,
                        let image = p["image"] as? String,
                        let body = p["body"] as? String,
                        let lat = p["lat"] as? Float,
                        let lon = p["lon"] as? Float {
                        
                        place = Place(title: title, body: body, image: image, lat: lat, lon: lon)
                        places.append(place)
                    }
                }
            }
        }
    }
}
