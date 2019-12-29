//
//  StartViewController.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 03/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private var startViewModel: StartViewModelProtocol
    
    private lazy var startView: StartView = {
        let startView = StartView()
        return startView
    }()
    
    // MARK: - INIT
    
    init(viewModel: StartViewModelProtocol) {
        self.startViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setViewClosures()
    }
    
    // MARK: - VIEW CLOSURES
    
    private func setViewClosures() {
        startView.onPlayButtonTapped = { [weak self] in
            guard let self = self else { return }

            let gameViewModel = self.startViewModel.createGameViewModel()
            let gameVC = GameViewController(viewModel: gameViewModel)
            self.navigationController?.pushViewController(gameVC, animated: true)
        }
        
        startView.onSettingsButtonTapped = { [weak self] in
            guard let self = self else { return }
    
            let settingsViewModel = self.startViewModel.createSettingsViewModel()
            let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
            self.navigationController?.pushViewController(settingsViewController, animated: true)
        }
    }
    
}
