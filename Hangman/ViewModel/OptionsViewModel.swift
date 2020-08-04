//
//  OptionsViewModel.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

struct OptionsViewModel: OptionsViewModelProtocol {
    
    let type: SettingsOptions
    let data: [String]
    
    // MARK: - PROTOCOL METHODS
     
    func getType() -> SettingsOptions {
        return type
    }
    
    func getDataCount() -> Int {
        return data.count
    }
    
    func getDataText(at row: Int) -> String {
        return data[row]
    }
    
    func setNewWordLanguage(at row: Int) -> Bool {
        if type == .wordLanguage {
            let selectedWordLanguage = data[row]
            let activeWordLanguage = GlobalSettings.wordLanguage
            
            if selectedWordLanguage != activeWordLanguage {
                GlobalSettings.wordLanguage = selectedWordLanguage
                return true
            }
        }
        return false
    }
    
}
