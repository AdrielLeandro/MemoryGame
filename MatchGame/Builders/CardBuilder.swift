//
//  CardBuilder.swift
//  MatchGame
//
//  Created by Adriel on 9/13/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation

class CardBuilder {

    func build(result: Result?) -> [Card] {
        var cards: [Card] = []
        
        _ = result?.products.map { product in
            let card = Card(id: product.id, imageFrontPath: product.image.src)
            cards.append(card)
        }
        
        return cards
    }

}
