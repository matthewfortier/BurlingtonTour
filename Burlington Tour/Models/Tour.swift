//
//  Tour.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/29/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import Foundation

class Tour: Item {
    var id: String
    var title: String
    
    var file: String
    var type: String
    var row: Int
    
    init(id: String, title: String, file: String, type: String) {
        self.id = id
        self.title = title
        
        self.file = file
        self.type = type
        self.row = 0
    }
}
