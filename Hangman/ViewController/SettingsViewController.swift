//
//  SettingsViewController.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - PROPERTIES

    private let settingsViewModel: SettingsViewModelProtocol
    
    private lazy var settingsView: SettingsView = {
        let settingsView = SettingsView()
        settingsView.settingsTableView.delegate = self
        settingsView.settingsTableView.dataSource = self
        return settingsView
    }()
    
    // MARK: - INIT
    
    init(viewModel: SettingsViewModelProtocol) {
        self.settingsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewClosures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       settingsView.settingsTableView.reloadData()
    }
    
    // MARK: - VIEW CLOSURES
    
    private func setViewClosures() {
        settingsView.onBackToStartView = { [weak self] in
            guard let self = self else { return }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func openWordLanguageVC() {
        let type = SettingsOptions.wordLanguage
        let optionsViewModel = settingsViewModel.createOptionsViewModel(type)
        let optionsViewController = OptionsViewController(viewModel: optionsViewModel)
        navigationController?.pushViewController(optionsViewController, animated: true)
    }
    
    private func openListOfAllWordsVC() {
        let type = SettingsOptions.listOfAllWords
        let optionsViewModel = settingsViewModel.createOptionsViewModel(type)
        let optionsViewController = OptionsViewController(viewModel: optionsViewModel)
        navigationController?.pushViewController(optionsViewController, animated: true)
    }
    
}

// MARK: - TABLE VIEW DATA SOURCE

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.getNumberOfOptionsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as! SettingsCell
        let option = settingsViewModel.getOptionForSection(at: indexPath)
        cell.settingsOption = option
        return cell
    }
    
}

// MARK: - TABLE VIEW DELEGATE

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Constants.mainColor
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = settingsViewModel.getSectionTitle(section)
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = Constants.backgroundColor
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.heightForHeaderInSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsViewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = settingsViewModel.getOptionForSection(at: indexPath)
        switch option {
        case .wordLanguage:
            openWordLanguageVC()
        case .listOfAllWords:
            openListOfAllWordsVC()
        default:
            break
        }
    }
    
}
