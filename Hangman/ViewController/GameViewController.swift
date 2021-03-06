//
//  GameViewController.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 01/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController {

    // MARK: - PROPERTIES

    private let gameViewModel: GameViewModelProtocol
    
    private var tappedLetterButtons = [UIButton]()
    
    private lazy var gameView: GameView = {
        let gameView = GameView()
        return gameView
    }()
    
    // MARK: - INIT
    
    init(viewModel: GameViewModelProtocol) {
        self.gameViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewClosures()
        fillUI()
    }
    
    // MARK: - VIEW CLOSURES
    
    private func setViewClosures() {
        gameView.onBackToStartView = { [weak self] in
            guard let self = self else { return }
            
            self.navigationController?.popViewController(animated: true)
        }
        
        gameView.onScoringSystems = { [weak self] in
            guard let self = self else { return }
            
            let popupVC = ScoringViewController()
            self.addChild(popupVC)
            popupVC.view.frame = self.view.frame
            self.view.addSubview(popupVC.view)
            popupVC.didMove(toParent: self)
        }
        
        gameView.onCheckIsTappedLetterInLookingWord = { [weak self] letterButton in
            guard let self = self else { return }
            
            self.disableAndAppendButtonInTappedLetterButtons(letterButton)
            self.checkLetterStatusAndChangeItsColor(letterButton)
            self.gameViewModel.checkIsGameFinished()
        }
        
    }
    
    // MARK: - PRIVATE METHODS
    
    private func fillUI() {
        
        //BINDS:
        
        gameViewModel.isUseShowHint.bindAndFire { [unowned self] (useShowHint: Bool) in
            if useShowHint {
                self.gameView.hintLabel.text = self.gameViewModel.hint
            }
        }
        
        gameViewModel.score.bindAndFire { [unowned self] (score: String) in
            self.gameView.scoreLabel.text = score
            self.gameViewModel.checkWeHaveNewBestScore()
        }

        gameViewModel.bestScore.bindAndFire { [unowned self] (bestScore: String) in
            self.gameView.bestScoreLabel.text = bestScore
        }
        
        gameViewModel.image.bindAndFire { [unowned self] (image: String) in
            self.gameView.hangmanImageView.image = UIImage(named: image)
        }
        
        gameViewModel.answere.bindAndFire { [unowned self] (answere: String) in
            self.gameView.answerTextField.text = answere
        }
        
        gameViewModel.isFinished.bind { [unowned self] (gameIsFinished: Bool) in
            if gameIsFinished {
                self.createAlertController(actionHandler: { [unowned self] (UIAlertAction) -> Void in
                    //start new game
                    self.gameViewModel.newWord()
                    self.fillUI()
                    self.enableAndRestoreTappedLetterButtons()
                })
            }
        }
        
    }
    
    private func createAlertController(actionHandler: ((UIAlertAction) -> Void)?) -> Void {
        let alertTitle = gameViewModel.alertTitle
        let alertMessage = gameViewModel.alertMessage
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.overrideUserInterfaceStyle = GlobalSettings.darkMode ? .light : .dark
        alertController.addAction(UIAlertAction(title: Constants.LocalizedString.newGame, style: .default, handler: actionHandler))
        present(alertController, animated: true)
    }
    
    private func enableAndRestoreTappedLetterButtons() {
        for letterButton in tappedLetterButtons {
            letterButton.isUserInteractionEnabled = true
            letterButton.backgroundColor = Constants.Colors.backgroundColor
        }
        tappedLetterButtons.removeAll()
    }
    
    private func disableAndAppendButtonInTappedLetterButtons(_ letterButton: UIButton) {
        letterButton.isUserInteractionEnabled = false
        tappedLetterButtons.append(letterButton)
    }
    
    private func checkLetterStatusAndChangeItsColor(_ letterButton: UIButton) {
        guard let tappedLetter = letterButton.titleLabel?.text else { return }
        let letterStatus = gameViewModel.isCorrectLetterTapped(tappedLetter)
        letterButton.backgroundColor = letterStatus ? UIColor.green : UIColor.red
    }
    
}
