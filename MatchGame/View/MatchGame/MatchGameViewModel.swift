//
//  MatchGameViewModel.swift
//  MatchGame
//
//  Created by Adriel on 9/11/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation

class MatchGameViewModel {

    private var game: Game

    var score: Int = 0 {
        didSet {
            game.score = score
            updateScore?(score)
        }
    }

    var machedCount: Int = 0 {
        didSet {
            game.mached = machedCount
            updateMached?(machedCount)

            if machedCount == game.size.hashValue {
                finishedGame?()
            }
        }
    }



    var cardViewModelArray: [CardCellViewModel] = [] {
        didSet {
            cardDidLoad?()
        }
    }

    var matchArray: [CardCellViewModel] = []
    var cards: [Card] = []
    var cardDidLoad: (() -> Void)?
    var updateScore: ((Int) -> Void)?
    var updateMached: ((Int) -> Void)?
    var finishedGame: (() -> Void)?
    var productService: ProductServiceProtocol

    init(game: Game, service: ProductServiceProtocol) {
        self.game = game
        self.productService = service
    }
}

extension MatchGameViewModel {

    func service() {
        productService.getProducts { (cards, error) in
            if let cards = cards {
                self.setupCardArray(cards: cards)
            } else {
                // HAY UN ERROR.
                // No Internet connection. Try again later. Ok.
            }
        }
    }

    private func setupCardArray(cards: [Card]) {
        self.cards = cards
        if cards.count < (game.size.value * game.difficult.value) {
            // No enough cards to play. Ok.
        } else {
            cardViewModelArray = Array(cards.prefix(game.size.value)).repeated(count: game.difficult.value).map { CardCellViewModel(card: $0)}
        }
    }

    func numberOfRow() -> Int {
        return cardViewModelArray.count
    }

    func getCardViewModel(indexPath: IndexPath) -> CardCellViewModel {
        return cardViewModelArray[indexPath.row]
    }

    func getSize() -> Int {
        return game.size.value
    }

    func setupSelectItem(indexPath: IndexPath) {
        if cardViewModelArray[indexPath.row].card.isFlipped {
            cardViewModelArray[indexPath.row].flipBack?()
        } else {
            cardViewModelArray[indexPath.row].flipCard?()
        }
        setupUpdateCard(indexPath: indexPath)
        setupMatchCard(indexPath: indexPath)
    }

    private func setupUpdateCard(indexPath: IndexPath) {
        cardViewModelArray[indexPath.row].card.isFlipped =  !cardViewModelArray[indexPath.row].card.isFlipped
    }

    private func setupMatchCard(indexPath: IndexPath) {
        matchArray.append(cardViewModelArray[indexPath.row])
        if matchArray.count >= 2 {
            compareMatchCard()
        }
    }

    private func compareMatchCard() {
        if matchArray.allEqual() {
            if game.difficult.value == matchArray.count {
                score += 20
                machedCount += 1
                for viewModel in matchArray {
                    viewModel.card.isMatched = true
                    viewModel.removeCard?()
                }
                matchArray.removeAll()
            }
        } else {
            score -= 1
            for viewModel in matchArray {
                viewModel.card.isFlipped = false
                viewModel.flipBack?()
            }

            matchArray.removeAll()
        }
    }

    func reload() {
        score = 0
        machedCount = 0
        cardViewModelArray = Array(cards.prefix(game.size.value)).repeated(count: game.difficult.value).map { CardCellViewModel(card: $0)}
        matchArray.removeAll()
    }

 }

