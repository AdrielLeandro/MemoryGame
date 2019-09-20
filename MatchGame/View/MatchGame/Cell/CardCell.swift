//
//  CardCell.swift
//  MatchGame
//
//  Created by Adriel on 9/11/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import UIKit
import SDWebImage

class CardCell: UICollectionViewCell, CellProtocol {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!

    private var viewModel: CardCellViewModel? {
        didSet {
            setupCell()
        }
    }

    private func setupCell() {
        setupUI()
        guard let viewModel = viewModel else {
            return
        }

        if viewModel.card.isMatched {
            stateImages(for: false)
            return
        } else {
            stateImages(for: true)
        }

        originalPosition(with: viewModel.card.isFlipped)

        viewModel.flipCard = { [weak self] in
            self?.flip()
        }

        viewModel.flipBack = { [weak self] in
            self?.flipBack()
        }

        viewModel.removeCard = { [weak self] in
            self?.remove()
        }
    }

    private func setupUI(){
        guard let viewModel = viewModel else {
            return
        }

        layer.cornerRadius = 5
        frontImageView.sd_setImage(with: URL(string: viewModel.card.imageFrontPath), placeholderImage: nil, options: [], context: nil)
    }

    private func flip() {
        isUserInteractionEnabled = false
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }

    private func flipBack() {
        isUserInteractionEnabled = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }

    private func remove() {
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
            self.backImageView.alpha = 0
        }) { (complete) in
            self.isUserInteractionEnabled = false
        }
    }

    private func stateImages(for display: Bool) {
        isUserInteractionEnabled = display
        self.frontImageView.alpha = display ? 1 : 0
        self.backImageView.alpha = display ? 1 : 0
    }

    private func originalPosition(with state: Bool) {
        UIView.transition(from: state ? backImageView : frontImageView, to: state ? frontImageView : backImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        isUserInteractionEnabled = !state
    }
    
}

extension CardCell {
    func fillCell(with viewModel: CardCellViewModel) {
        self.viewModel = viewModel
    }
}
