//
//  UserLink.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/29/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import Foundation

class UserLink: NSObject, Item, NSCoding {
    var id: String
    var title: String
    var url: String
    
    init(title: String, url: String) {
        self.id = UUID().uuidString
        self.title = title
        self.url = url
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(url, forKey: "url")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.url = aDecoder.decodeObject(forKey: "url") as! String
    }
}
