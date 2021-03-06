//
//  SettingsViewController.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

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
        let optionsViewModel = settingsViewModel.createOptionsViewModel(ofType: .wordLanguage)
        let optionsViewController = OptionsViewController(viewModel: optionsViewModel)
        navigationController?.pushViewController(optionsViewController, animated: true)
    }
    
    private func openListOfAllWordsVC() {
        let optionsViewModel = settingsViewModel.createOptionsViewModel(ofType: .listOfAllWords)
        let optionsViewController = OptionsViewController(viewModel: optionsViewModel)
        navigationController?.pushViewController(optionsViewController, animated: true)
    }
    
}

// MARK: - TABLE VIEW DATA SOURCE

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.getNumberOfOptions(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as? SettingsCell else { return UITableViewCell() }
        let option = settingsViewModel.getOptionForSection(at: indexPath)
        cell.settingsOption = option
        return cell
    }
    
}

// MARK: - TABLE VIEW DELEGATE

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Constants.Colors.mainColor
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = settingsViewModel.getSectionTitle(in: section)
        title.font = .boldSystemFont(ofSize: Constants.FontSizes.medium.rawValue)
        title.textColor = Constants.Colors.backgroundColor
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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
