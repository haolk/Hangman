//
//  SettingsView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func backToStartView()
}

class SettingsView: UIView {
    
    // MARK: - PROPERTIES
    
    private var backButton: UIButton!
    private var titleLabel: UILabel!
    private var userInfoHeader: UserInfoHeader!
    
    var settingsTableView: UITableView!
    
    weak var delegate: SettingsViewDelegate?
    
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
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.init(name: "Marker Felt", size: 26)
        titleLabel.textColor = Constants.mainColor
        titleLabel.textAlignment = .center
        //titleLabel.layer.borderColor = UIColor.black.cgColor
        //titleLabel.layer.borderWidth = 2
        titleLabel.text = NSLocalizedString("SETTINGS", comment: "")
        addSubview(titleLabel)
        
        settingsTableView = UITableView(frame: frame, style: .grouped)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        //settingsTableView.allowsSelection = true
        //settingsTableView.allowsMultipleSelection = false
        settingsTableView.rowHeight = 50
        settingsTableView.sectionFooterHeight = 0

        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
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
        delegate?.backToStartView()
    }
    
    @objc private func enableDarkMode() {
        overrideUserInterfaceStyle = GlobalSettings.darkMode ? .dark : .light
    }
    
}
