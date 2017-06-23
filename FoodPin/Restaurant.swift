//
//  Restaurant.swift
//  FoodPin
//
//  Created by Katherine Dexter on 4/3/17.
//  Copyright © 2017 KDexter. All rights reserved.
//

import Foundation


class Restaurant {
    
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisited = false
    var phone = ""
    var rating = ""

    init(name: String, type: String, location: String, image: String, phone: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.isVisited = isVisited
        
    }
    

}
