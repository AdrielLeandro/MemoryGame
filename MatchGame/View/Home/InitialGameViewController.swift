//
//  InitialGame.swift
//  MatchGame
//
//  Created by Adriel on 9/14/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import UIKit

class InitialGameViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.extraLargeRegularFont
        label.text = "Game \nMached"
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var startButton: UIButton = {
        let button = CustomButton()
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(didTouchStartButton), for: .touchUpInside)
        button.alpha = 0
        return button
    }()

    var selectDifficultViewController = SelectViewController()
    var selectSizeViewController = SelectViewController()

    var viewModel: InitialGameViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Palette.lightBrown
        setupUI()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func setupUI() {
        setupTitleLabel()
        setupContainerView()
        setupSelectDifficult()
        setupStarButton()
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func setupContainerView() {
        view.addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }

    private func setupStarButton() {
        view.addSubview(startButton)
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 40).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    @objc private func didSelectDifficult() {
        selectSizeViewController.viewModel = viewModel?.getSizeViewModel()
        cycleFromViewController(oldViewController: selectDifficultViewController, toViewController: selectSizeViewController, view: containerView)
    }

    @objc private func didTouchStartButton() {
        guard let game = viewModel?.getMatchGame() else { return }

        let matchGameViewController = MatchGameViewController()
        matchGameViewController.viewModel = MatchGameViewModel(game: game, service: ProductService())
        navigationController?.pushViewController(matchGameViewController, animated: true)
        cleanView()
    }

    private func cleanView() {
        startButton.alpha = 0
        selectDifficultViewController.remove()
        selectSizeViewController.remove()
        viewModel?.cleanViewModel()
        selectDifficultViewController = SelectViewController()
        selectSizeViewController = SelectViewController()
        setupSelectDifficult()
    }

    private func setupViewModel() {
        viewModel?.didSelectDifficult = { [weak self] in
            self?.didSelectDifficult()
            self?.startButton.alpha = 1
        }

        viewModel?.didSelectSize = { [weak self] in
            self?.startButton.isUserInteractionEnabled = true
        }
    }

    private func setupSelectDifficult() {
        selectDifficultViewController.viewModel = viewModel?.getDifficultViewModel()
        add(selectDifficultViewController, view: containerView)
    }

}
