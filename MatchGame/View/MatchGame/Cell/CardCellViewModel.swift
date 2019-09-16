
//
//  CardCellViewModel.swift
//  MatchGame
//
//  Created by Adriel on 9/11/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation

class CardCellViewModel {

    var card: Card
    var flipCard: (() -> Void)?
    var flipBack: (() -> Void)?
    var removeCard: (() -> Void)?

    init(card: Card) {
        self.card = card
    }

}

extension CardCellViewModel: Equatable {
    static func == (lhs: CardCellViewModel, rhs: CardCellViewModel) -> Bool {
        return lhs.card.id == rhs.card.id
    }
}
