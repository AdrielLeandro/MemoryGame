//
//  OptionCellViewModel.swift
//  MatchGame
//
//  Created by Adriel on 9/14/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation

class OptionCellViewModel {

    var updateCell: (() -> Void)?
    var selected: Bool = false {
        didSet {
            updateCell?()
        }
    }
    var title: String

    init(title: String) {
        self.title = title
    }
}
