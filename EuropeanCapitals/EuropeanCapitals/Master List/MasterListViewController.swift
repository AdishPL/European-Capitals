//
//  MasterListViewController.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import UIKit

protocol MasterListViewControllerDelegate: class {
    func masterListViewControllerDelegateDidSelectCapital(_ capital: Capital)
}

final class MasterListViewController: NiblessViewController {
    private let tableView: UITableView = UITableView()
    
    weak var delegate: MasterListViewControllerDelegate?
    
    private var viewModel: MasterListViewModel!
    
    init(with viewModel: MasterListViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    override func loadView() {
        super.loadView()
        
        title = AppStrings.capitals
        view.backgroundColor = UIColor.white
        
        setupTableView()
        setupFavoritesButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadCapitals { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(CapitalTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 300.0
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupFavoritesButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: AppStrings.favorites, style: .plain, target: self, action: #selector(showFavorites))
    }
    
    @objc private func showFavorites() {
        viewModel.showFavorites = !viewModel.showFavorites
        navigationItem.rightBarButtonItem?.title = viewModel.showFavorites ? AppStrings.all : AppStrings.favorites
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension MasterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(CapitalTableViewCell.self, forIndexPath: indexPath)
        cell.favoriteButtonCallback = { [unowned self] in
            DispatchQueue.main.async {
                viewModel.toggleFavorite(atIndex: indexPath.row)
            }
        }
        viewModel.configure(cell, atIndex: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MasterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let capital = viewModel.item(atIndex: indexPath.row) {
            delegate?.masterListViewControllerDelegateDidSelectCapital(capital)
        }
    }
}
