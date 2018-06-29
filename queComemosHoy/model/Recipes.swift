//
//  Recipes.swift
//  queComemosHoy
//
//  Created by Gianni on 20/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import Foundation
import ObjectMapper

class Recipes: Mappable{
    
    var recipe: Recipe?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        recipe <- map["recipe"]
    }
    
}

