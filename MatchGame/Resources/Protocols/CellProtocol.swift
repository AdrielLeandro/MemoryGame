//
//  CellProtocol.swift
//  MatchGame
//
//  Created by Adriel on 9/11/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import UIKit

protocol CellProtocol: class {
    static var identifier: String { get }
}

extension CellProtocol where Self: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension CellProtocol where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
