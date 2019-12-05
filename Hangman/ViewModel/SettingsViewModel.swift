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
    
    func getNumberOfOptionsInSection(_ section: Int) -> Int {
        return getSections()[section].options.count
    }
    
    func getOptionForSection(at indexPath: IndexPath) -> SettingsOptions {
        return getSections()[indexPath.section].options[indexPath.row]
    }
    
    func getSectionTitle(_ section: Int) -> String {
        return getSections()[section].title.description
    }
    
    func getSectionCount() -> Int {
        return getSections().count
    }
    
    // MARK: - PRIVATE METHODS
    
    private func getSections() -> [SettingsSection] {
        let sections: [SettingsSection] = [
            SettingsSection(title: .general, options: [SettingsOptions.wordLanguage, SettingsOptions.showHint]),
            SettingsSection(title: .misc, options: [SettingsOptions.listOfAllWords])
        ]
        return sections
    }
    
}

