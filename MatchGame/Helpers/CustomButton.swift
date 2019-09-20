//
//  CustomButtom.swift
//  MatchGame
//
//  Created by Adriel on 9/17/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDefaultStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureDefaultStyle()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureDefaultStyle()
    }

    private func configureDefaultStyle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.font = UIFont.smallRegularFont
        self.layer.borderColor = Palette.beige.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }

}
