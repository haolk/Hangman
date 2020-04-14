//
//  StartView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 16/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

final class StartView: UIView {
    
    // MARK: - ACTION CLOSURES
    
    var onPlayButtonTapped: () -> Void = {}
    var onSettingsButtonTapped: () -> Void = {}
    
    // MARK: - PROPERTIES

    @Label(ofSize: 55, textAlignment: .center, text: NSLocalizedString("HANGMAN", comment: ""))
    var titleLabel: UILabel
    
    @Button(borderWidth: 1, cornerRadius: 5, iconSize: 50, iconSystemName: "play.fill", iconWeight: .black)
    var playButton: UIButton
    
    @Button(borderWidth: 1, cornerRadius: 5, iconSize: 40, iconSystemName: "gear")
    var settingsButton: UIButton
    
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
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
    }
    
    private func addElementsOnView() {
        addSubview(titleLabel)
        addSubview(playButton)
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
    
    // MARK: - SELECTORS METHODS
    
    @objc private func playButtonTapped() {
        onPlayButtonTapped()
    }
    
    @objc private func settingsButtonTapped() {
        onSettingsButtonTapped()
    }
    
    @objc private func enableDarkMode() {
        overrideUserInterfaceStyle = GlobalSettings.darkMode ? .dark : .light
    }
    
}
