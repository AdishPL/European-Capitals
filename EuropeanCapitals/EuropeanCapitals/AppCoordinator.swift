//
//  AppCoordinator.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 11/08/2020.
//

import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)
    
    func start()
}

class AppCoordinator: CoordinatorProtocol {
    private var window: UIWindow?

    var navigationController: UINavigationController

    required init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        showMasterListViewController()
    }
    
    func start(on window: UIWindow?) {
        guard let window = window else {
            fatalError("Cannot initialize AppCoordinator without UIWindow")
        }
        
        self.window = window
        start()
    }
    
    func showMasterListViewController() {
        /// Initialize viewModel
        let viewModel = MasterListViewModel()

        /// Initialize viewController and inject viewModel
        let viewController = MasterListViewController(with: viewModel)
        viewController.delegate = self
        
        /// Set viewController as rootViewController in navigationController
        navigationController.viewControllers = [viewController]
    }
    
    func showDetailsViewController(withCapital capital: Capital) {
        /// Initialize viewModel
        let viewModel = DetailsListViewModel(for: capital)
        
        /// Initialize viewController and inject viewModel
        let viewController = DetailsListViewController(with: viewModel)
        viewController.delegate = self

        /// Push viewController in navigation stack
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - MasterListViewControllerDelegate

extension AppCoordinator: MasterListViewControllerDelegate {
    func masterListViewControllerDelegateDidSelectCapital(_ capital: Capital) {
        showDetailsViewController(withCapital: capital)
    }
}

// MARK: - DetailsListViewControllerDelegate

extension AppCoordinator: DetailsListViewControllerDelegate {
    func detailsListViewControllerDelegateDidSelectMoreInfo(_ info: CityInfo?) {
        #warning("To be implemented")
    }
}
