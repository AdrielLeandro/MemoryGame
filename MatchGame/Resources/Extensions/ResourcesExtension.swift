//
//  ResourcesExtension.swift
//  MatchGame
//
//  Created by Adriel on 9/12/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import Foundation
import UIKit

extension Collection {
    func allEqual<T: Equatable>(by key: KeyPath<Element, T>) -> Bool {
        return allSatisfy { first?[keyPath:key] == $0[keyPath:key] }
    }
}

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        return allSatisfy { first == $0 }
    }
}

extension Array {
    init(repeating: [Element], count: Int) {
        self.init([[Element]](repeating: repeating, count: count).flatMap{$0})
    }

    func repeated(count: Int) -> [Element] {
        return [Element](repeating: self, count: count)
    }
}

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }

    func localizedFormat(arguments: CVarArg..., using tableName: String?, in bundle: Bundle?) -> String {
        return String(format: localized, arguments: arguments)
    }
}

extension UIViewController {

    func configureNavigationWith(controller: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.barTintColor = Palette.beige
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont.largeRegularFont]
        return navigationController
    }


    func add(_ child: UIViewController, view: UIView) {
        addChild(child)

        child.view.frame = view.frame

        view.addSubview(child.view)
        defaultConstraint(childView: child.view, contentView: view)

        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }


    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController, view: UIView) {
        oldViewController.willMove(toParent: nil)

        addChild(newViewController)
        view.addSubview(newViewController.view)
        defaultConstraint(childView: newViewController.view, contentView: view)


        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()

        UIView.animate(withDuration: 0.4, delay: 0.1, options: .transitionFlipFromLeft, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        }) { (finished) in
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            newViewController.didMove(toParent: self)
        }
    }

    func defaultConstraint(childView: UIView, contentView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        childView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        childView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
