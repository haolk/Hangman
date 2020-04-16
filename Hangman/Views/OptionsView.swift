//
//  OptionsView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

final class OptionsView: UIView {
    
    // MARK: - ACTION CLOSURES
    
    var onBackToStartView: () -> Void = {}
    
    // MARK: - PROPERTIES
  
    @Button(iconSize: Constants.ButtonSizes.small, iconSystemName: "arrowshape.turn.up.left.fill")
    var backButton: UIButton
    
    @Label(ofSize: Constants.FontSizes.large, textAlignment: .center)
    var titleLabel: UILabel
    
    @SwipeGesture(swipteDirection: .right)
    var swipeBack: UISwipeGestureRecognizer
    
    var optionsTableView = UITableView()
    
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
        backButton.addTarget(self, action: #selector(backToSettingsView), for: .touchUpInside)
        swipeBack.addTarget(self, action: #selector(backToSettingsView))
    }

    private func addElementsOnView() {
        addSubview(backButton)
        addSubview(titleLabel)
        addGestureRecognizer(swipeBack)
        
        optionsTableView = UITableView(frame: frame, style: .grouped)
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        optionsTableView.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.reuseIdentifier)
        optionsTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 10))
        optionsTableView.tableHeaderView?.backgroundColor = Constants.Colors.backgroundColor
        addSubview(optionsTableView)
    }
        
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            backButton.leadingAnchor .constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -50),
            optionsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            optionsTableView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            optionsTableView.rightAnchor.constraint(equalTo: rightAnchor),
            optionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - SELECTORS METHODS
    
    @objc private func backToSettingsView() {
        onBackToStartView()
    }
    
    @objc private func enableDarkMode() {
        overrideUserInterfaceStyle = GlobalSettings.darkMode ? .dark : .light
    }
    
}
