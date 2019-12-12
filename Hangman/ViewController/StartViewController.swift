//
//  StartViewController.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 03/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, StartViewDelegate {
    
    // MARK: - PROPERTIES
    
    private var startViewModel: StartViewModelProtocol
    
    private lazy var startView: StartView = {
        let startView = StartView()
        startView.delegate = self
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
    }
    
    // MARK: - SELECTORS METHODS
    
    func playButtonTapped() {
        let game = startViewModel.startGame()
        let gameViewModel = GameViewModel(startViewModel.wordsRepository, game)
        let gameVC = GameViewController(viewModel: gameViewModel)
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    func settingsButtonTapped() {
        let settingsViewModel = SettingsViewModel(wordsRepository: startViewModel.wordsRepository)
        let settingsVC = SettingsViewController(viewModel: settingsViewModel)
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
}
