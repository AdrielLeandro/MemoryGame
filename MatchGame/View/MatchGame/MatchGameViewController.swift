//
//  MatchGameView.swift
//  MatchGame
//
//  Created by Adriel on 9/11/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import UIKit

class MatchGameViewController: UIViewController, Loadable {

    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = Palette.beige
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Chalkduster", size: 18)
        label.text = "match-screen.point".localizedFormat(0)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()

    lazy var machedCardCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Chalkduster", size: 18)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()

    lazy var pointBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Palette.beige
        return view
    }()

    let containerLoader = ContainerLoader()
    var viewModel: MatchGameViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewModel()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startLoading()
    }

    private func setupUI() {
        setupPointBarView()
        setupCollectionView()
        setupNavigation()
    }

    private func setupNavigation() {
        title = "title".localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTouchQuitButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "reload-icon"), style: .plain, target: self, action: #selector(didTouchReloadButton))

    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CardCell.identifier, bundle: nil), forCellWithReuseIdentifier: CardCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: pointBarView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupPointBarView() {
        view.addSubview(pointBarView)
        pointBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pointBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pointBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pointBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        pointBarView.addSubview(scoreLabel)
        scoreLabel.leadingAnchor.constraint(equalTo: pointBarView.leadingAnchor, constant: 10).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: pointBarView.centerYAnchor).isActive = true

        pointBarView.addSubview(machedCardCountLabel)
        machedCardCountLabel.trailingAnchor.constraint(equalTo: pointBarView.trailingAnchor, constant: -10).isActive = true
        machedCardCountLabel.centerYAnchor.constraint(equalTo: pointBarView.centerYAnchor).isActive = true
    }

    private func setupViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        machedCardCountLabel.text = "match-screen.mached".localizedFormat(" 0/\(viewModel.getSize())")
        
        viewModel.service()

        viewModel.cardDidLoad = { [weak self] in
            self?.collectionView.reloadData()
            self?.stopLoading()
        }

        viewModel.updateScore = { [weak self] score in
            self?.scoreLabel.text = "match-screen.point".localizedFormat(score)
        }

        viewModel.updateMached = { [weak self] mached in
            let size = viewModel.getSize()
            self?.machedCardCountLabel.text = "match-screen.mached".localizedFormat("\(mached)/\(size)")
        }

        viewModel.finishedGame = { [weak self] in
            self?.alertFinishedGame()
        }
    }

    private func alertFinishedGame() {
        let alert = UIAlertController(title: "alert.title".localized, message: "alert.message".localized, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "alert.ok-button".localized, style: .default) {[weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        })

        present(alert, animated: true, completion: .none)
    }

    @objc private func didTouchQuitButton() {
        let alert = UIAlertController(title: nil, message: "alert.second-message".localized, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "alert.ok-button".localized, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        })

        alert.addAction(UIAlertAction(title: "alert.cancel-button".localized, style: .destructive, handler: nil))

        present(alert, animated: true, completion: .none)
    }

    @objc private func didTouchReloadButton() {
        let alert = UIAlertController(title: nil, message: "alert.third-message".localized, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "alert.ok-button".localized, style: .default) { _ in
            self.viewModel?.reload()
        })

        alert.addAction(UIAlertAction(title: "alert.cancel-button".localized, style: .destructive, handler: nil))

        present(alert, animated: true, completion: .none)
    }
}

extension MatchGameViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }

        return viewModel.numberOfRow()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath)

        if let cell = cell as? CardCell {
            cell.fillCell(with: viewModel.getCardViewModel(indexPath: indexPath))
            return cell
        }
        return UICollectionViewCell()
    }

}

extension MatchGameViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.setupSelectItem(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width * 0.2 - 20, height: view.bounds.width * 0.3 - 20)
    }

}
