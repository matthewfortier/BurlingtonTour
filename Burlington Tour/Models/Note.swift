//
//  Note.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/29/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import Foundation

class Note: NSObject, Item, NSCoding {
    var id: String
    var title: String
    
    var body: String
    var image: String
    
    init(title: String, file: String, body: String) {
        self.id = UUID().uuidString
        self.title = title
        
        self.image = file
        self.body = body
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(body, forKey: "body")
        aCoder.encode(image, forKey: "image")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.body = aDecoder.decodeObject(forKey: "body") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
    }
    
}

