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
    }
    
    func start(on window: UIWindow?) {
        guard let window = window else {
            fatalError("Cannot initialize AppCoordinator without UIWindow")
        }
        
        self.window = window
        start()
    }
}
