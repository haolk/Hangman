//
//  SettingsView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {
    func backToStartView()
    func openWordLanguageVC()
    func openListOfAllWordsVC()
}

class SettingsView: UIView {
    fileprivate var backButton: UIButton!
    fileprivate var titleLabel: UILabel!
    fileprivate var userInfoHeader: UserInfoHeader!
    
    fileprivate var settingsTableView: UITableView!
    
    weak var delegate: SettingsDelegate?
    
    var sections: [SettingsSection] = [
        SettingsSection(title: .general, options: [SettingsOptions.wordLanguage, SettingsOptions.showHint]),
        SettingsSection(title: .misc, options: [SettingsOptions.listOfAllWords])
    ]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = .white
    }
    
    fileprivate func setup() {
        backButton = UIButton()
        let backIconConfig = UIImage.SymbolConfiguration(pointSize: 26)
        let backIcon = UIImage(systemName: "arrowshape.turn.up.left.fill", withConfiguration: backIconConfig)
        backButton.setImage(backIcon, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = Constants.BLUE
        backButton.addTarget(self, action: #selector(backToStartView), for: .touchUpInside)
        addSubview(backButton)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.init(name: "Marker Felt", size: 26)
        titleLabel.textColor = Constants.BLUE
        titleLabel.textAlignment = .center
        //titleLabel.layer.borderColor = UIColor.black.cgColor
        //titleLabel.layer.borderWidth = 2
        titleLabel.text = "Settings"
        addSubview(titleLabel)
        
        settingsTableView = UITableView(frame: frame, style: .grouped)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        //settingsTableView.allowsSelection = true
        //settingsTableView.allowsMultipleSelection = false
        settingsTableView.rowHeight = 50
        settingsTableView.sectionFooterHeight = 0

        let frame = CGRect(x: 0, y: 88, width: self.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        settingsTableView.tableHeaderView = userInfoHeader
        addSubview(settingsTableView)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
            backButton.leadingAnchor .constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -50),
            settingsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            settingsTableView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            settingsTableView.rightAnchor.constraint(equalTo: rightAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc fileprivate func backToStartView() {
        delegate?.backToStartView()
    }
    
}

extension SettingsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as? SettingsCell {
            let option = sections[indexPath.section].options[indexPath.row]
            cell.settingsOption = option
            return cell
            
        } else {
            fatalError("Unknown identifier")
        }
        
    }
    
}

extension SettingsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Constants.BLUE
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = sections[section].title.description
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = .white
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = sections[indexPath.section].options[indexPath.row] 
        switch option {
        case .wordLanguage:
            delegate?.openWordLanguageVC()
        case .listOfAllWords:
            delegate?.openListOfAllWordsVC()
        default:
            print(option)
        }
    }
    
}
