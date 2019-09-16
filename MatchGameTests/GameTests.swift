//
//  GameTests.swift
//  MatchGameTests
//
//  Created by Adriel on 9/15/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import XCTest
@testable import MatchGame

class GameTests: XCTestCase {
    func testWhenGameIsInitialized() {
        let game = Game(difficult: .easy, size: .low)
        XCTAssertEqual(game.size.rawValue, 10)
        XCTAssertEqual(game.difficult.rawValue, 2)
    }
}
