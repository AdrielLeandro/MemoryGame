//
//  SelectViewController.swift
//  MatchGame
//
//  Created by Adriel on 9/14/19.
//  Copyright © 2019 Adriel Pinzas. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.largeRegularFont
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()

    var viewModel: SelectViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
    }

    private func setupUI() {
        setupLabel()
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:  10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        tableView.register(UINib(nibName: OptionCell.identifier, bundle: nil), forCellReuseIdentifier: OptionCell.identifier)
    }

    private func setupLabel() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    }


    private func setupViewModel() {
        guard let viewModel = viewModel else {
            return
        }

        titleLabel.text = viewModel.typeOption.didplayMessage
        
        viewModel.optionDidLoad = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.setupOptionArray()
    }

}

extension SelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getNumberOfRow()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.identifier, for: indexPath) as? OptionCell else {
            return UITableViewCell()
        }
        cell.setViewModel(viewModel: viewModel.getOptionCellViewModel(indexPath: indexPath))
        return cell
    }
}

extension SelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectCell(indexPath: indexPath)
    }
}
