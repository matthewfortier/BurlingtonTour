//
//  Place.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/29/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

class Place: Item {
    var id: String
    var title: String
    
    var body: String
    var lat: Float
    var lon: Float
    var image: String
    
    init(id: String, title: String, body: String, image: String, lat: Float, lon: Float) {
        self.id = id
        self.title = title
        self.body = body
        self.image = image
        self.lat = lat
        self.lon = lon
    }
}
