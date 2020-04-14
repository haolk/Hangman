//
//  GameView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 16/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

final class GameView: UIView {
    
    // MARK: - ACTION CLOSURES
    
    var onBackToStartView: () -> Void = {}
    var onCheckIsTappedLetterInLookingWord: (UIButton) -> Void = {_ in }

    // MARK: - PROPERTIES
    
    @Button(iconSize: 26, iconSystemName: "arrowshape.turn.up.left.fill")
    var backButton: UIButton
  
    @Label(ofSize: 26, textAlignment: .right)
    var bestScoreLabel: UILabel
    
    @Label(ofSize: 26, textAlignment: .right)
    var scoreLabel: UILabel
    
    @ImageView()
    var hangmanImageView: UIImageView
    
    @TextField(fontSize: 26)
    var answerTextField: UITextField
    
    @Label(ofSize: 16, textAlignment: .center, textColor: .label)
    var hintLabel: UILabel
    
    @StackView(spacing: 8)
    var stackView1: UIStackView
    
    @StackView(spacing: 4)
    var stackView2: UIStackView
    
    @StackView(spacing: 8)
    var stackView3: UIStackView
    
    @StackView(spacing: 4)
    var stackView4: UIStackView
    
    @SwipeGesture(swipteDirection: .right)
    var swipeBack: UISwipeGestureRecognizer
    
    // MARK: - INIT
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - PRIVATE METHODS

    private func setup() {
        ThemeManager.addDarkModeObserver(to: self, selector: #selector(enableDarkMode))
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = Constants.backgroundColor
        
        enableDarkMode()
        addTargetOnElements()
        addElementsOnView()
        setConstraintsForElements()
    }
    
    private func addTargetOnElements() {
        backButton.addTarget(self, action: #selector(backToStartView), for: .touchUpInside)
        swipeBack.addTarget(self, action: #selector(backToStartView))
    }
    
    private func addElementsOnView() {
        addSubview(backButton)
        addSubview(bestScoreLabel)
        addSubview(scoreLabel)
        addSubview(hangmanImageView)
        addSubview(answerTextField)
        addSubview(hintLabel)
        addSubview(stackView1)
        addSubview(stackView2)
        addSubview(stackView3)
        addSubview(stackView4)
        addGestureRecognizer(swipeBack)
        
        addLettersRow(startPosition: 0, numberOfLettersInRow: 6, stackView: stackView1)
        addLettersRow(startPosition: 6, numberOfLettersInRow: 7, stackView: stackView2)
        addLettersRow(startPosition: 13, numberOfLettersInRow: 6, stackView: stackView3)
        addLettersRow(startPosition: 19, numberOfLettersInRow: 7, stackView: stackView4)
    }
     
    private func addLettersRow(startPosition: Int, numberOfLettersInRow: Int, stackView: UIStackView) {
        for letter in 0..<numberOfLettersInRow {
            let letterButton = UIButton(type: .custom)
            letterButton.frame = CGRect(x: 0, y: 0, width: 45, height: 40)
            letterButton.layer.cornerRadius = 0.5 * letterButton.bounds.size.width
            letterButton.layer.borderColor = UIColor.lightGray.cgColor
            letterButton.layer.borderWidth = 1.0
            letterButton.clipsToBounds = true
            letterButton.titleLabel?.font = UIFont.init(name: Constants.font, size: 30)
            letterButton.setTitle(Constants.letters[startPosition + letter], for: .normal)
            letterButton.setTitleColor(Constants.mainColor, for: .normal)
            letterButton.contentHorizontalAlignment = .center
            letterButton.contentVerticalAlignment = .center
            letterButton.addTarget(self, action: #selector(checkIsTappedLetterInLookingWord(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(letterButton)
         }
     }
     
    private func setConstraintsForElements() {
        backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        
        bestScoreLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        bestScoreLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        
        scoreLabel.topAnchor.constraint(equalTo: bestScoreLabel.bottomAnchor, constant: 10).isActive = true
        scoreLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        
        hangmanImageView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 15).isActive = true
        hangmanImageView.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.8).isActive = true
        hangmanImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        hangmanImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        
        answerTextField.topAnchor.constraint(equalTo: hangmanImageView.bottomAnchor, constant: 20).isActive = true
        answerTextField.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.7).isActive = true
        answerTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        hintLabel.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: 5).isActive = true
        hintLabel.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.9).isActive = true
        hintLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        
        stackView1.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 50).isActive = true
        stackView1.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 1.0).isActive = true
        stackView1.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        
        stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 5).isActive = true
        stackView2.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 1.0).isActive = true
        stackView2.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        
        stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 5).isActive = true
        stackView3.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 1.0).isActive = true
        stackView3.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        
        stackView4.topAnchor.constraint(equalTo: stackView3.bottomAnchor, constant: 5).isActive = true
        stackView4.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 1.0).isActive = true
        stackView4.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        stackView4.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    // MARK: - SELECTORS METHODS
    
    @objc private func backToStartView() {
        onBackToStartView()
    }
    
    @objc private func checkIsTappedLetterInLookingWord(_ letterButton: UIButton) {
        onCheckIsTappedLetterInLookingWord(letterButton)
    }
    
    @objc private func enableDarkMode() {
        overrideUserInterfaceStyle = GlobalSettings.darkMode ? .dark : .light
    }
    
}
