//
//  ListRecipes.swift
//  queComemosHoy
//
//  Created by Gianni on 21/6/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import Foundation
import ObjectMapper

class ListRecipes: Mappable{
    
    var hits: [Recipes]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        hits          <- map["hits"]        
    }
    
}
