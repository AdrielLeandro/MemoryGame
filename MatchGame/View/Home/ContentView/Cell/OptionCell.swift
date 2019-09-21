//
//  OptionCell.swift
//  MatchGame
//
//  Created by Adriel on 9/14/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    private var viewModel: OptionCellViewModel? {
        didSet {
            setupViewModel()
        }
    }

    private func setupViewModel() {
        guard let viewModel = viewModel else {
            return
        }

        titleLabel.text = viewModel.title
        viewModel.updateCell = { [weak self] selected in
            if selected {
                self?.containerView.backgroundColor =  Palette.wheat
            } else {
                self?.containerView.backgroundColor =  Palette.beige
            }
        }

    }

    private func updateSelect(state: Bool) {
        self.containerView.backgroundColor = !state ? UIColor.white : UIColor.red
    }
}

extension OptionCell {
    func setViewModel(viewModel: OptionCellViewModel) {
        self.viewModel = viewModel
    }
}
