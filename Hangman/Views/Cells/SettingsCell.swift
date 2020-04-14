//
//  SettingsCell.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

final class SettingsCell: UITableViewCell {
    static let reuseIdentifier = "SettingsCell"
    
    // MARK: - PROPERTIES
    
    @Label(textAlignment: .left)
    var labelText: UILabel
    
    @Switch()
    var switchControl: UISwitch
    
    var settingsOption: SettingsOptions? {
        didSet {
            guard let settingsOption = settingsOption else { return }
            labelText.text = settingsOption.description
            switchControl.isHidden = !settingsOption.containsSwitch
            accessoryType = settingsOption.isDisclosureIndicator ? .disclosureIndicator : .none
            selectionStyle = settingsOption.isDisclosureIndicator ? .default : .none
            
            if settingsOption == .showHint {
                switchControl.isOn = GlobalSettings.useShowHint
            } else if settingsOption == .darkMode {
                switchControl.isOn = GlobalSettings.darkMode
            }
        }
    }
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemnted")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        addTargetOnElements()
        addElementsOnView()
        setConstraintsForElements()
    }
    
    private func addTargetOnElements() {
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
    }
    
    private func addElementsOnView() {
        addSubview(labelText)
        addSubview(switchControl)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            labelText.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 5),
            labelText.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, constant: -10),
            labelText.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            switchControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        ])
    }
    
    // MARK: - SELECTORS METHODS
    
    @objc func handleSwitchAction(sender: UISwitch) {
        guard let settingsOption = settingsOption else { return }
        if settingsOption == .showHint {
            GlobalSettings.useShowHint = sender.isOn ? true : false
        } else if settingsOption == .darkMode {
            sender.isOn ? ThemeManager.enableDarkMode() : ThemeManager.disableDarkMode()
        }
    }
    
}
