//
//  Item.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/19/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import Foundation
import UIKit

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
    
    init(order: Int, title: String, body: String, image: String, lat: Float, lon: Float) {
        self.order = order
        self.title = title
        self.body = body
        self.image = image
        self.lat = lat
        self.lon = lon
    }
}

class Tour: Item {
    var order = -1
    var title: String
    
    var file: String
    var type: String
    
    init(order: Int, title: String, file: String, type: String) {
        self.order = order
        self.title = title
        
        self.file = file
        self.type = type
    }
}

class Note: Item {
    var title: String
    var order = -1
    
    var body: String
    var image: UIImage
    
    init(order: Int, title: String, file: UIImage, body: String) {
        self.order = order
        self.title = title
        
        self.image = file
        self.body = body
    }
}
