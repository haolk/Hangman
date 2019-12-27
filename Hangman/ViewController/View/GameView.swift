//
//  GameView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 16/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func backToStartView()
    func checkIsTappedLetterInLookingWord(_ letterButton: UIButton)
}

class GameView: UIView {

    // MARK: - PROPERTIES
    
    private var backButton: UIButton!
    var bestScoreLabel: UILabel!
    var scoreLabel: UILabel!
    var imageView: UIImageView!
    var answerTextfield: UITextField!
    var hintLabel: UILabel!
    private var stackView1: UIStackView!
    private var stackView2: UIStackView!
    private var stackView3: UIStackView!
    private var stackView4: UIStackView!
    
    weak var delegate: GameViewDelegate?
    
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
        addElementsOnView()
        setConstraintsForElements()
    }
    
    private func addElementsOnView() {
        backButton = UIButton()
        let backIconConfig = UIImage.SymbolConfiguration(pointSize: 26)
        let backIcon = UIImage(systemName: "arrowshape.turn.up.left.fill", withConfiguration: backIconConfig)
        backButton.setImage(backIcon, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = Constants.mainColor
        backButton.addTarget(self, action: #selector(backToStartView), for: .touchUpInside)
        addSubview(backButton)
        
        bestScoreLabel = UILabel()
        bestScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        bestScoreLabel.font = UIFont.init(name: "Marker Felt", size: 26)
        bestScoreLabel.textColor = Constants.mainColor
        bestScoreLabel.textAlignment = .right
        addSubview(bestScoreLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont.init(name: "Marker Felt", size: 26)
        scoreLabel.textColor = Constants.mainColor
        scoreLabel.textAlignment = .right
        //scoreLabel.layer.borderColor = UIColor.black.cgColor
        //scoreLabel.layer.borderWidth = 2
        addSubview(scoreLabel)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        //imageView.layer.borderColor = UIColor.black.cgColor
        //imageView.layer.borderWidth = 2
        addSubview(imageView)
        
        answerTextfield = UITextField()
        answerTextfield.translatesAutoresizingMaskIntoConstraints = false
        answerTextfield.font = UIFont.init(name: "Marker Felt", size: 26)
        answerTextfield.textAlignment = .center
        answerTextfield.isUserInteractionEnabled = false
        //answerTextfield.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        //answerTextfield.layer.borderColor = UIColor.black.cgColor
        //answerTextfield.layer.borderWidth = 2
        addSubview(answerTextfield)
        
        hintLabel = UILabel()
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.font = UIFont.init(name: "Marker Felt", size: 16)
        hintLabel.textAlignment = .center
        //hintLabel.layer.borderColor = UIColor.black.cgColor
        //hintLabel.layer.borderWidth = 2
        addSubview(hintLabel)
        
        stackView1 = UIStackView()
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.distribution = .fillEqually
        stackView1.axis = .horizontal
        stackView1.spacing = 8
        addSubview(stackView1)
        
        stackView2 = UIStackView()
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.distribution = .fillEqually
        stackView2.axis = .horizontal
        stackView2.spacing = 4
        addSubview(stackView2)
        
        stackView3 = UIStackView()
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView3.distribution = .fillEqually
        stackView3.axis = .horizontal
        stackView3.spacing = 8
        addSubview(stackView3)
        
        stackView4 = UIStackView()
        stackView4.translatesAutoresizingMaskIntoConstraints = false
        stackView4.distribution = .fillEqually
        stackView4.axis = .horizontal
        stackView4.spacing = 4
        addSubview(stackView4)
        
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
            letterButton.titleLabel?.font = UIFont.init(name: "Marker Felt", size: 30)
            letterButton.setTitle(Constants.letters[startPosition + letter], for: .normal)
            letterButton.setTitleColor(Constants.mainColor, for: .normal)
            letterButton.contentHorizontalAlignment = .center
            letterButton.contentVerticalAlignment = .center
            letterButton.addTarget(self, action: #selector(checkIsTappedLetterInLookingWord(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(letterButton)
         }
     }
     
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            
            bestScoreLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            bestScoreLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: bestScoreLabel.bottomAnchor, constant: 10),
            scoreLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.8),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            answerTextfield.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            answerTextfield.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.7),
            answerTextfield.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            hintLabel.topAnchor.constraint(equalTo: answerTextfield.bottomAnchor, constant: 5),
            hintLabel.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.9),
            hintLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            stackView1.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 50),
            stackView1.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 1.0),
            stackView1.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 5),
            stackView2.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 1.0),
            stackView2.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 5),
            stackView3.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 1.0),
            stackView3.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            stackView4.topAnchor.constraint(equalTo: stackView3.bottomAnchor, constant: 5),
            stackView4.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 1.0),
            stackView4.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            stackView4.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -5)
        ])
    }
    
    // MARK: - SELECTORS METHODS
    
    @objc private func backToStartView() {
        delegate?.backToStartView()
    }
    
    @objc private func checkIsTappedLetterInLookingWord(_ letterButton: UIButton) {
        delegate?.checkIsTappedLetterInLookingWord(letterButton)
    }
    
    @objc private func enableDarkMode() {
        overrideUserInterfaceStyle = GlobalSettings.darkMode ? .dark : .light
    }
    
}
