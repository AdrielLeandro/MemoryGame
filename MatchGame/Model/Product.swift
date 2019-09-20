//
//  Product.swift
//  MatchGame
//
//  Created by Adriel on 9/12/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation
import Mapper

struct Product: Mappable {
    
    let id: Int
    let image: ProductImage

    init(map: Mapper) throws {
        id = try map.from("id")
        image = try map.from("image")
    }
    
}
