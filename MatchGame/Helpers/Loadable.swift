//
//  Loadable.swift
//  MatchGame
//
//  Created by Adriel on 9/14/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation
import UIKit

protocol Loadable: class {
    var containerLoader: ContainerLoader { get }
    func startLoading()
    func stopLoading()
}

extension Loadable where Self: UIViewController {

    func startLoading() {

        containerLoader.frame.size = CGSize(width: 80, height: 80)
        containerLoader.center = view.center
        view.addSubview(containerLoader)

        containerLoader.loader.startAnimating()

    }

    func stopLoading() {

        containerLoader.loader.stopAnimating()
        containerLoader.removeFromSuperview()

    }

}

class ContainerLoader: UIView{

    let loader = UIActivityIndicatorView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100)))

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Palette.beige
        layer.cornerRadius = 10
        clipsToBounds = true

        setupActivityControl()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Error - Container Loader")
    }

    private func setupActivityControl(){
        loader.center = CGPoint(x: 40, y: 40)
        loader.hidesWhenStopped = true
        loader.style = .gray
        addSubview(loader)

    }

}

