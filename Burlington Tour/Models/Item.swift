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
    var id: String {get set}
    var order: Int {get set}
    var title: String {get set}
}

class Place: Item {
    var id: String
    var order = -1
    var title: String
    
    var body: String
    var lat: Float
    var lon: Float
    var image: String
    
    init(id: String, order: Int, title: String, body: String, image: String, lat: Float, lon: Float) {
        self.id = id
        self.order = order
        self.title = title
        self.body = body
        self.image = image
        self.lat = lat
        self.lon = lon
    }
}

class Tour: Item {
    var id: String
    var order = -1
    var title: String
    
    var file: String
    var type: String
    var row: Int
    
    init(id: String, order: Int, title: String, file: String, type: String) {
        self.id = id
        self.order = order
        self.title = title
        
        self.file = file
        self.type = type
        self.row = 0
    }
}

class Note: NSObject, Item, NSCoding {
    var id: String
    var title: String
    var order = -1
    
    var body: String
    var image: UIImage
    
    init(order: Int, title: String, file: UIImage, body: String) {
        self.id = UUID().uuidString
        self.order = order
        self.title = title
        
        self.image = file
        self.body = body
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(order, forKey: "order")
        aCoder.encode(body, forKey: "body")
        aCoder.encode(image, forKey: "image")
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.order = aDecoder.decodeInteger(forKey: "order")
        self.body = aDecoder.decodeObject(forKey: "body") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! UIImage
    }
    
}

class UserLink: NSObject, Item, NSCoding {
    var id: String
    var order = -1
    var title: String
    var url: String
    
    init(order: Int, title: String, url: String) {
        self.id = UUID().uuidString
        self.order = order
        self.title = title
        self.url = url
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(order, forKey: "order")
        aCoder.encode(url, forKey: "url")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.order = aDecoder.decodeInteger(forKey: "order")
        self.url = aDecoder.decodeObject(forKey: "url") as! String
    }
}

class Favorite: NSObject, NSCoding {
    var id: String
    var type: String
    
    init(id: String, type: String) {
        self.id = id
        self.type = type
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(type, forKey: "type")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.type = aDecoder.decodeObject(forKey: "type") as! String
    }
}

