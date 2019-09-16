//
//  InitialGameViewModel.swift
//  MatchGame
//
//  Created by Adriel on 9/14/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation

class InitialGameViewModel {

    var difficultOption: Game.Difficult?
    var sizeOption: Game.Size?

    var didSelectDifficult: (() -> Void)?
    var didSelectSize: (() -> Void)?

    func getDifficultViewModel() -> SelectViewModel {
        return SelectViewModel(typeOption: .difficult, selectOption: { (optionDifficult) in
            self.didSelectDifficult?()
            self.difficultOption = Game.Difficult(rawValue: optionDifficult)
        })
    }

    func getSizeViewModel() -> SelectViewModel {
        return SelectViewModel(typeOption: .size, selectOption: { (optionSize) in
            self.didSelectSize?()
            self.sizeOption = Game.Size(rawValue: optionSize)
        })
    }

    func getMatchGame() -> Game? {
        guard let difficultOption = difficultOption, let sizeOption = sizeOption else {
            return nil
        }

        return Game(difficult: difficultOption, size: sizeOption)
    }
}
