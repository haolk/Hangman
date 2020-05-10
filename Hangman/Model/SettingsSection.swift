//
//  SettingsSection.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

protocol SettingsSectionProtocol: CustomStringConvertible {
    var containsSwitch: Bool { get }
    var isDisclosureIndicator: Bool { get }
}

struct SettingsSection {
    let title: SettingsTitle
    let options: [SettingsOptions]
}

enum SettingsTitle: Int, CaseIterable {
    case general
    case misc
    
    var description: String {
        switch self {
        case .general: return Constants.LocalizedString.general
        case .misc: return Constants.LocalizedString.misc
        }
    }
}

enum SettingsOptions: Int, CaseIterable, SettingsSectionProtocol {
    case wordLanguage
    case showHint
    case darkMode
    case listOfAllWords
    
     var description: String {
        switch self {
        case .wordLanguage: return Constants.LocalizedString.wordLanguage
        case .showHint: return Constants.LocalizedString.showHint
        case .darkMode: return Constants.LocalizedString.darkMode
        case .listOfAllWords: return Constants.LocalizedString.listOfWords
        }
    }
    
    var containsSwitch: Bool {
        switch self {
        case .wordLanguage: return false
        case .showHint: return true
        case .darkMode: return true
        case .listOfAllWords: return false
        }
    }
    
    var isDisclosureIndicator: Bool {
        switch self {
        case .wordLanguage: return true
        case .showHint: return false
        case .darkMode: return false
        case .listOfAllWords: return true
        }
    }
    
}
