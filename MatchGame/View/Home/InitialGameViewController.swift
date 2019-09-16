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
        label.font = UIFont(name: "Chalkduster", size: 50)
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

    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Chalkduster", size: 15)
        button.layer.borderColor = Palette.beige.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(didTouchContinueButton), for: .touchUpInside)
        return button
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: "Chalkduster", size: 15)
        button.layer.borderColor = Palette.beige.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTouchBackButton), for: .touchUpInside)
        return button
    }()

    lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont(name: "Chalkduster", size: 15)
        button.layer.borderColor = Palette.beige.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(didTouchStartButton), for: .touchUpInside)
        return button
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()


    let selectDifficultViewController = SelectViewController()
    let selectSizeViewController = SelectViewController()

    var viewModel: InitialGameViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Palette.lightBrown
        setupUI()
        setupViewModel()
    }


    func setupUI() {
        setupTitleLabel()
        setupContainerView()
        setupSelectDifficult()
        setupSelectSize()
        setupStackView()
        setupButton()
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

    private func setupButton() {
        continueButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        backButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        startButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setupStackView() {
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 30).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        stackView.addArrangedSubview(continueButton)
    }

    @objc private func didTouchContinueButton() {
        cycleFromViewController(oldViewController: selectDifficultViewController, toViewController: selectSizeViewController, view: containerView)
        stackView.removeArrangedSubview(continueButton)
        continueButton.removeFromSuperview()
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(startButton)
    }

    @objc private func didTouchBackButton() {
        cycleFromViewController(oldViewController: selectSizeViewController, toViewController: selectDifficultViewController, view: containerView)
        stackView.removeArrangedSubview(backButton)
        stackView.removeArrangedSubview(startButton)
        backButton.removeFromSuperview()
        startButton.removeFromSuperview()
        stackView.addArrangedSubview(continueButton)
    }

    @objc private func didTouchStartButton() {
        guard let game = viewModel?.getMatchGame() else { return }

        let matchGameViewController = MatchGameViewController()
        matchGameViewController.viewModel = MatchGameViewModel(game: game, service: ProductService())
        navigationController?.pushViewController(matchGameViewController, animated: true)
        //Limpiar view model 
    }

    private func setupSelectDifficult() {
        selectDifficultViewController.viewModel = viewModel?.getDifficultViewModel()
        add(selectDifficultViewController, view: containerView)
    }

    private func setupSelectSize() {
        selectSizeViewController.viewModel = viewModel?.getSizeViewModel()
    }

    private func setupViewModel() {
        viewModel?.didSelectDifficult = { [weak self] in
            self?.continueButton.isUserInteractionEnabled = true
        }

        viewModel?.didSelectSize = { [weak self] in
            self?.startButton.isUserInteractionEnabled = true
        }
    }

}
