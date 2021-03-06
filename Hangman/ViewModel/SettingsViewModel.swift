//
//  SettingsViewModel.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

struct SettingsViewModel: SettingsViewModelProtocol {
    
    let wordsRepository: WordsRepository
    
    // MARK: - PROTOCOL METHODS
    
    func getNumberOfOptions(inSection section: Int) -> Int {
        return getSections()[section].options.count
    }
    
    func getOptionForSection(at indexPath: IndexPath) -> SettingsOptions {
        return getSections()[indexPath.section].options[indexPath.row]
    }
    
    func getSectionTitle(in section: Int) -> String {
        return getSections()[section].title.description
    }
    
    func getSectionCount() -> Int {
        return getSections().count
    }
    
    func createOptionsViewModel(ofType type: SettingsOptions) -> OptionsViewModel {
        let data = getData(for: type)
        return OptionsViewModel(type: type, data: data)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func getSections() -> [SettingsSection] {
        let sections: [SettingsSection] = [
            SettingsSection(title: .general, options: [.wordLanguage, .showHint, .darkMode]),
            SettingsSection(title: .misc, options: [.listOfAllWords])
        ]
        return sections
    }
    
    private func getData(for type: SettingsOptions) -> [String] {
        switch type {
        case .wordLanguage:
            return getWordLanguages()
        case .listOfAllWords:
            return getActiveWordsAndHints()
        default:
            return [""]
        }
    }
    
    private func getWordLanguages() -> [String] {
        return WordLanguages.allCases.map { $0.description }
    }
    
    private func getActiveWordsAndHints() -> [String] {
        let activeWordsAndHints = wordsRepository.getActiveWordsAndHints() ?? [WordDetails]()
        return activeWordsAndHints.map({ $0.word + "-(\($0.hint))" })
    }
    
}
