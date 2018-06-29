//
//  Recipe.swift
//  queComemosHoy
//
//  Created by Gianni on 21/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import Foundation
import ObjectMapper

class Recipe: Mappable{
    
    
    var name: String?
    var url: String?
    var ingredients: [String]?
    var image_url: String?
    var calories: Int?
    var time: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name         <- map["label"]
        url          <- map["url"]
        ingredients  <- map["ingredientLines"]
        image_url    <- map["image"]
        calories     <- map["calories"]
        time         <- map["totalTime"]
    }
    
}
