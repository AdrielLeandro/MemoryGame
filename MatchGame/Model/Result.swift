//
//  Result.swift
//  MatchGame
//
//  Created by Adriel on 9/12/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation
import Mapper

struct Result: Mappable {
    let products: [Product]

    init(map: Mapper) throws {
        products = try map.from("products")

    }

}
