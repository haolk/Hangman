//
//  SettingsCell.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    static let reuseIdentifier = "InfoCell"
    
    let defaults = UserDefaults.standard
    
    // MARK: - PROPERTIES
    
    var settingsOption: SettingsOptions? {
        didSet {
            guard let settingsOption = settingsOption else { return }
            textLabel?.text = settingsOption.description
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
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.onTintColor = Constants.BLUE
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(switchControl)
        
        NSLayoutConstraint.activate([
            switchControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemnted")
    }
    
    // MARK: - SELECTORS
    
    @objc func handleSwitchAction(sender: UISwitch) {
        guard let settingsOption = settingsOption else { return }
        if settingsOption == .showHint {
            GlobalSettings.useShowHint = sender.isOn ? true : false
        } else if settingsOption == .darkMode {
            sender.isOn ? ThemeManager.enableDarkMode() : ThemeManager.disableDarkMode()
        }
    }
    
}

