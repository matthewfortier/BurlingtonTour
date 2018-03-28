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
    var fav: Bool
    
    init(order: Int, title: String, body: String, image: String, lat: Float, lon: Float, fav: Bool) {
        self.order = order
        self.title = title
        self.body = body
        self.image = image
        self.lat = lat
        self.lon = lon
        self.fav = fav
    }
}

class Tour: Item {
    var order = -1
    var title: String
    
    var file: String
    var type: String
    var fav: Bool
    var row: Int
    
    init(order: Int, title: String, file: String, type: String, fav: Bool) {
        self.order = order
        self.title = title
        
        self.file = file
        self.type = type
        self.fav = fav
        self.row = 0
    }
}

class Note: NSObject, Item, NSCoding {
    
    var title: String
    var order = -1
    
    var body: String
    var image: UIImage
    var fav:Bool
    
    init(order: Int, title: String, file: UIImage, body: String, fav: Bool) {
        self.order = order
        self.title = title
        
        self.image = file
        self.body = body
        self.fav = fav
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(order, forKey: "order")
        aCoder.encode(body, forKey: "body")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(fav, forKey: "fav")
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.order = aDecoder.decodeInteger(forKey: "order")
        self.body = aDecoder.decodeObject(forKey: "body") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! UIImage
        self.fav = false
    
    }
    
}

class UserLink: NSObject, Item, NSCoding {
    var order = -1
    var title: String
    var url: String
    
    init(order: Int, title: String, url: String) {
        self.order = order
        self.title = title
        
        self.url = url
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(order, forKey: "order")
        aCoder.encode(url, forKey: "url")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.order = aDecoder.decodeInteger(forKey: "order")
        self.url = aDecoder.decodeObject(forKey: "url") as! String
    }
}

