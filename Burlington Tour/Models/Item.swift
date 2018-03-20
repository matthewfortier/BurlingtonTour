//
//  Item.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/19/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import Foundation

protocol Item {
    var order: Int {get set}
    var title: String {get set}
}

class Place: Item {
    var order = -1
    var title: String
    
    var body: String
    var lat: Float
    var lon: Float
    var image: String
    
    init(title: String, body: String, image: String, lat: Float, lon: Float) {
        self.title = title
        self.body = body
        self.image = image
        self.lat = lat
        self.lon = lon
    }
    
    init() {
        self.title = ""
        self.body = "blah blah"
        self.image = ""
        self.lat = 0.0
        self.lon = 0.0
    }
}
