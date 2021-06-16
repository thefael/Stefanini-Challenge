//
//  SceneDelegate.swift
//  Stefanini-Challenge
//
//  Created by Rafael Rodrigues on 14/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        
        let viewController = GalleryViewController()
        let navigationController = UINavigationController(rootViewController: viewController)

        window.rootViewController = navigationController

        self.window = window
        window.makeKeyAndVisible()
    }
}

