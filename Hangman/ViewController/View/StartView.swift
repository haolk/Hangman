//
//  StartView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 16/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

protocol StartViewDelegate: class {
    func playButtonTapped()
    func settingsButtonTapped()
}

class StartView: UIView {
    private var titleLabel: UILabel!
    private var playButton: UIButton!
    private var settingsButton: UIButton!
    
    weak var delegate: StartViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        backgroundColor = Constants.BACKGROUND_COLOR
        addElementsOnView()
        setConstraintsForElements()
    }
    
    private func addElementsOnView() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "HANGMAN"
        titleLabel.textColor = Constants.BLUE
        titleLabel.font = UIFont.init(name: Constants.FONT, size: 55)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        let playIconConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .black)
        let playIcon = UIImage(systemName: "play.fill", withConfiguration: playIconConfig)
        playButton.setImage(playIcon, for: .normal)
        playButton.layer.borderWidth = 1
        playButton.layer.cornerRadius = 5
        playButton.layer.borderColor = Constants.BLUE.cgColor
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        addSubview(playButton)
        
        settingsButton = UIButton()
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        let settingsIconConfig = UIImage.SymbolConfiguration(pointSize: 40)
        let settingsIcon = UIImage(systemName: "gear", withConfiguration: settingsIconConfig)
        settingsButton.setImage(settingsIcon, for: .normal)
        settingsButton.layer.borderWidth = 1
        settingsButton.layer.cornerRadius = 5
        settingsButton.layer.borderColor = Constants.BLUE.cgColor
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        addSubview(settingsButton)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            playButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            playButton.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            playButton.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.4),
            
            settingsButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
            settingsButton.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            settingsButton.widthAnchor.constraint(equalTo: playButton.widthAnchor)
        ])
    }
    
    // MARK: - BUTTON ACTION METHODS
    
    @objc private func playButtonTapped() {
        delegate?.playButtonTapped()
    }
    
    @objc private func settingsButtonTapped() {
        delegate?.settingsButtonTapped()
    }
    
}
