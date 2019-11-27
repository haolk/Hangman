//
//  GameViewController.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 01/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewDelegate {

    fileprivate var gameViewModel: GameViewModelProtocol
    
    fileprivate var tappedLetterButtons = [UIButton]()
    
    private lazy var gameView: GameView = {
        let gameView = GameView()
        gameView.delegate = self
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
        fillUI()
    }
    
    // MARK: - BUTTON ACTION METHODS
    
    func backToStartView() {
        navigationController?.popViewController(animated: true)
    }
    
    func letterButtonTapped(_ letterButton: UIButton) {
        guard let tappedLetter = letterButton.titleLabel?.text else { return }
        appendInTappedButtons(letterButton)
        let letterStatus = gameViewModel.letterButtonTapped(tappedLetter)
        letterButton.backgroundColor = letterStatus ? UIColor.green : UIColor.red
        gameViewModel.checkIsGameFinished()
    }
    
    // MARK: - PRIVATE METHODS
    
    fileprivate func fillUI() {
        
        gameView.hintLabel.text = gameViewModel.hint
        
        //BINDS:
        gameViewModel.score.bindAndFire { [unowned self] in self.gameView.scoreLabel.text = $0 }
        gameViewModel.image.bindAndFire { [unowned self] in self.gameView.imageView.image = UIImage(named: $0) }
        gameViewModel.answere.bindAndFire({ [unowned self] in self.gameView.answerTextfield.text = $0 })
        
        gameViewModel.isFinished.bindAndFire { [weak self] in
            if $0 {
                let alertTitle = self?.gameViewModel.alertTitle
                let alertMessage = self?.gameViewModel.alertMessage
                let ac = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: { [weak self] _ in
                    self?.gameViewModel.newWord()
                    self?.fillUI()
                    self?.restoreLetterButtons()
                }))
                self?.present(ac, animated: true, completion: nil)
            }
        }

    }
    
    fileprivate func appendInTappedButtons(_ letterButton: UIButton) {
        letterButton.isUserInteractionEnabled = false
        tappedLetterButtons.append(letterButton)
    }
    
    fileprivate func restoreLetterButtons() {
        for letterButton in tappedLetterButtons {
            letterButton.isUserInteractionEnabled = true
            letterButton.backgroundColor = .white
        }
        tappedLetterButtons.removeAll()
    }

}
