//
//  SceneDelegate.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 01/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let wordsRepository = WordsRepository()
        let starViewModel = StartViewModel(wordsRepository: wordsRepository)
        let mainController = StartViewController(viewModel: starViewModel)
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
