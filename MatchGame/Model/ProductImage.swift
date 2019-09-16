//
//  ProductImage.swift
//  MatchGame
//
//  Created by Adriel on 9/13/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation
import Mapper

struct ProductImage: Mappable {

    let src: String

    init(map: Mapper) throws {
        src = try map.from("src")
    }

}
