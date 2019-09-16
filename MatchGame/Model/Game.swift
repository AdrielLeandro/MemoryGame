//
//  Game.swift
//  MatchGame
//
//  Created by Adriel on 9/13/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation

struct Game {
    
    let difficult: Difficult
    var score: Int
    var mached: Int
    let size: Size

    init(difficult: Difficult, size: Size) {
        self.difficult = difficult
        self.mached = 0
        self.score = 0
        self.size = size
    }
}

extension Game {

    enum Difficult: Int {
        case easy = 2
        case medium = 3
        case hard = 4

        var value: Int {
            switch self {
            case .easy: return 2
            case .medium: return 3
            case .hard: return 4
            }
        }

        var title: String {
            switch self {
            case .easy: return "Easy"
            case .medium: return "Medium"
            case .hard: return "Hard"
            }
        }
    }

    enum Size: Int {
        case low = 10
        case medium = 15
        case high = 20

        var value: Int {
            switch self {
            case .low: return 10
            case .medium: return 15
            case .high: return 20
            }
        }

        var title: String {
            switch self {
            case .low: return "Low"
            case .medium: return "Medium"
            case .high: return "High"
            }
        }
    }

}
