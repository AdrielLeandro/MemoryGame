//
//  Card.swift
//  MatchGame
//
//  Created by Adriel on 9/11/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation

struct Card {
    let imageFrontPath: String
    let id: Int
    var isFlipped = false
    var isMatched = false

    init(id: Int, imageFrontPath: String) {
        self.imageFrontPath = imageFrontPath
        self.id = id
    }
}
