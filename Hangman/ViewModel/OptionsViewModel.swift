//
//  OptionsViewModel.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

struct OptionsViewModel: OptionsViewModelProtocol {
    
    let wordsRepository: WordsRepository
    let type: SettingsOptions
    
    // MARK: - PROTOCOL METHODS
     
    func getType() -> SettingsOptions {
        return type
    }
    
    func getDataCount() -> Int {
        return getData().count
    }
    
    func getDataText(at row: Int) -> String {
        return getData()[row]
    }
    
    func setNewWordLanguage(at row: Int) -> Bool {
        if type == .wordLanguage {
            let selectedWordLanguage = getData()[row]
            let activeWordLanguage = GlobalSettings.wordLanguage
            
            if selectedWordLanguage != activeWordLanguage {
                GlobalSettings.wordLanguage = selectedWordLanguage
                return true
            }
        }
        return false
    }
    
    // MARK: - PRIVATE METHODS
    
    private func getData() -> [String] {
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
