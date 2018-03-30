//
//  Favorite.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/29/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import Foundation

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
