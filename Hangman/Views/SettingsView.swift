//
//  SettingsView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

final class SettingsView: UIView {
    
    // MARK: - ACTION CLOSURES
    
    var onBackToStartView: () -> Void = {}
    
    // MARK: - PROPERTIES
  
    @Button(iconSize: .small, iconSystemName: .back)
    var backButton: UIButton
    
    @Label(text: Constants.LocalizedString.settings, fontSize: .large, textAlignment: .center)
    var titleLabel: UILabel
    
    @SwipeGesture(swipteDirection: .right)
    var swipeBack: UISwipeGestureRecognizer
    
    var settingsTableView = UITableView()
    
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
        backgroundColor = Constants.Colors.backgroundColor

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
        addSubview(titleLabel)
        addGestureRecognizer(swipeBack)
        
        settingsTableView = UITableView(frame: frame, style: .grouped)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        settingsTableView.sectionFooterHeight = 0

        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
        let userInfoHeader = UserInfoHeader(frame: frame)
        settingsTableView.tableHeaderView = userInfoHeader
        addSubview(settingsTableView)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            backButton.leadingAnchor .constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -50),
            settingsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            settingsTableView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            settingsTableView.rightAnchor.constraint(equalTo: rightAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - SELECTORS METHODS
    
    @objc private func backToStartView() {
        onBackToStartView()
    }
    
    @objc private func enableDarkMode() {
        overrideUserInterfaceStyle = GlobalSettings.darkMode ? .dark : .light
    }
    
}
