//
//  SelectViewModel.swift
//  MatchGame
//
//  Created by Adriel on 9/14/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation

class SelectViewModel {
    let difficultArray = [Game.Difficult.easy, Game.Difficult.medium, Game.Difficult.hard]
    let sizeArray = [Game.Size.low, Game.Size.medium, Game.Size.high]

    var viewModelArray: [OptionCellViewModel] = [] {
        didSet {
            optionDidLoad?()
        }
    }
    var selectOption:((Int) -> Void)?
    var optionDidLoad: (() -> Void)?
    let typeOption: TypeOption

    init(typeOption: TypeOption, selectOption: ((Int) -> Void)?) {
        self.typeOption = typeOption
        self.selectOption = selectOption
    }

}

extension SelectViewModel {

    func setupOptionArray() {
        switch typeOption {
        case .difficult:
            viewModelArray = difficultArray.map { type -> OptionCellViewModel in
                switch type {
                case .easy:
                    return OptionCellViewModel(title: "Easy")
                case .medium:
                    return OptionCellViewModel(title: "Medium")
                case .hard:
                    return OptionCellViewModel(title: "Hard")
                }
            }
        case .size:
            viewModelArray = sizeArray.map { type -> OptionCellViewModel in
                switch type {
                case .low:
                    return OptionCellViewModel(title: "20")
                case .medium:
                    return OptionCellViewModel(title: "30")
                case .high:
                    return OptionCellViewModel(title: "40")
                }
            }
        }
    }

    func getNumberOfRow() -> Int {
       return 3
    }

    func getOptionCellViewModel(indexPath: IndexPath) -> OptionCellViewModel {
        return viewModelArray[indexPath.row]
    }

    func didSelectCell(indexPath: IndexPath) {
        for (index,viewModel) in viewModelArray.enumerated() {
            if index != indexPath.row {
                viewModel.selected = false
            } else {
                viewModel.selected = true
                typeOption == .difficult ? selectOption?(difficultArray[indexPath.row].value) : selectOption?(sizeArray[indexPath.row].value)
            }
        }
    }

}

extension SelectViewModel {
    enum TypeOption {
        case difficult
        case size

        var didplayMessage: String {
            switch self {
            case .difficult: return "Select your difficulty:"
            case .size: return "Select your size:"
            }
        }
    }
}
