//
//  SceneDelegate.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 11/08/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let appCoordinator = AppCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene: UIWindowScene = scene as? UIWindowScene else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        
        setupAppearance()
        appCoordinator.start(on: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}

private extension SceneDelegate {
    private func setupAppearance() {
        UINavigationBar.appearance().barTintColor = AppStyling.colorWhite
        UINavigationBar.appearance().tintColor = AppStyling.colorPrimary
        UINavigationBar.appearance().isTranslucent = false

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppStyling.colorDarkGray,
            NSAttributedString.Key.font: AppStyling.fontRegular(size: 18)
        ]
    }
}
