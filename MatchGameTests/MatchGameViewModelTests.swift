//
//  MatchGameViewModelTests.swift
//  MatchGameTests
//
//  Created by Adriel on 9/15/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import XCTest
@testable import MatchGame

class MatchGameViewModelTests: XCTestCase {

    func testWhenUserGetsError () {
        let game = Game(difficult: .easy, size: .low)
        let service = ProductServiceMock()
        service.getProductHandler = { completion in
            completion(nil, "Error")
        }
        let viewModel = MatchGameViewModel(game: game, service: service)

        viewModel.service()
        XCTAssertEqual(viewModel.cardViewModelArray.count, 0)
    }

    func testWhenUserGetsCards () {
        let game = Game(difficult: .easy, size: .low)
        let service = ProductServiceMock()
        service.getProductHandler = { completion in
            let cards = [Card(id: 0234, imageFrontPath: "Tralala"),
                         Card(id: 0234, imageFrontPath: "Tralala")]
            completion(cards, nil)
        }

        let viewModel = MatchGameViewModel(game: game, service: service)

        viewModel.service()
        XCTAssertEqual(viewModel.cards.count, 2)
    }

    func testWhenGameIsEasyAndSizeIsLowButNotEnoughCard() {
        let game = Game(difficult: .easy, size: .low)
        let service = ProductServiceMock()
        service.getProductHandler = { completion in
            let cards = [Card(id: 0234, imageFrontPath: "Tralala"),
                         Card(id: 0234, imageFrontPath: "Tralala")]
            completion(cards, nil)
        }

        let viewModel = MatchGameViewModel(game: game, service: service)

        viewModel.service()
        XCTAssertEqual(viewModel.cards.count, 2)
        XCTAssertEqual(viewModel.cardViewModelArray.count, 0)
    }

    func testWhenGameIsEasyAndSizeIsLow() {
        let game = Game(difficult: .easy, size: .low)
        let service = ProductServiceMock()
        service.getProductHandler = { completion in
            let cards = [Card(id: 0234, imageFrontPath: "Tralala")].repeated(count: 40)
            completion(cards, nil)
        }

        let viewModel = MatchGameViewModel(game: game, service: service)

        viewModel.service()
        XCTAssertEqual(viewModel.cards.count, 40)
        XCTAssertEqual(viewModel.cardViewModelArray.count, 20)
    }

    func testWhenGameIsHardAndSizeIsHigh() {
        let game = Game(difficult: .hard, size: .high)
        let service = ProductServiceMock()
        service.getProductHandler = { completion in
            let cards = [Card(id: 0234, imageFrontPath: "Tralala")].repeated(count: 200)
            completion(cards, nil)
        }

        let viewModel = MatchGameViewModel(game: game, service: service)

        viewModel.service()
        XCTAssertEqual(viewModel.cards.count, 200)
        XCTAssertEqual(viewModel.cardViewModelArray.count, 80)
    }
}

class ProductServiceMock: ProductServiceProtocol {
    var getProductHandler: (([Card]?, String?) -> Void) -> Void = { _ in }

    func getProducts(_ completion: @escaping (([Card]?, String?) -> Void)) {
        getProductHandler(completion)
    }
}

