//
//  DetailsListViewController.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 21/08/2020.
//

import UIKit

protocol DetailsListViewControllerDelegate: class {
    func detailsListViewControllerDelegateDidSelectMoreInfo(_ info: CityInfo?)
}

final class DetailsListViewController: NiblessViewController {
    private let tableView: UITableView = UITableView()

    weak var delegate: DetailsListViewControllerDelegate?
    
    private let viewModel: DetailsListViewModel
    
    init(with viewModel: DetailsListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
      super.loadView()
        
        title = viewModel.name
        
        view.backgroundColor = UIColor.white
        
        setupTableView()
        setupDetailsButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadAllData { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(CapitalTableViewCell.self)
        tableView.register(DetailsTableViewCell.self)
        
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
    
    private func setupDetailsButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: AppStrings.details, style: .plain, target: self, action: #selector(showMore))
    }
    
    @objc private func showMore() {
        delegate?.detailsListViewControllerDelegateDidSelectMoreInfo(viewModel.info)
    }
}

// MARK: - UITableViewDataSource

extension DetailsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellType(forIndexPath: indexPath)
        switch cellType {
        case .capitalCellType:
            let cell = tableView.dequeueCell(CapitalTableViewCell.self, forIndexPath: indexPath)
            cell.favoriteButtonCallback = { [unowned self] in
                DispatchQueue.main.async {
                    viewModel.toggleFavorite(atIndex: indexPath.row)
                }
            }
            viewModel.configureCapitalCell(cell, atIndex: indexPath.row)
            return cell
        case .detailsCellType:
            let cell = tableView.dequeueCell(DetailsTableViewCell.self, forIndexPath: indexPath)
            viewModel.configureDetailsCell(cell, atIndex: indexPath.row)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension DetailsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = viewModel.cellType(forIndexPath: indexPath)
        switch cellType {
        case .capitalCellType:
            return UITableView.automaticDimension
        case .detailsCellType:
            return 50.0
        }
    }
}
