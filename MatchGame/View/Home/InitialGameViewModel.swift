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
        return SelectViewModel(typeOption: .difficult, selectOption: { [weak self] (optionDifficult) in
            guard let self = self else { return }
            self.didSelectDifficult?()
            self.difficultOption = Game.Difficult(rawValue: optionDifficult)
        })
    }

    func getSizeViewModel() -> SelectViewModel {
        return SelectViewModel(typeOption: .size, selectOption: { [weak self] (optionSize) in
            guard let self = self else { return }

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

    func cleanViewModel() {
        difficultOption = nil
        sizeOption = nil
    }
}
