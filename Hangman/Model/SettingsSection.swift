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
    var title: SettingsTitle
    var options: [SettingsOptions]
    
    init(title: SettingsTitle, options: [SettingsOptions]) {
        self.title = title
        self.options = options
    }
    
}

enum SettingsTitle: Int, CaseIterable {
    case general
    case misc
    
    var description: String {
        switch self {
        case .general: return "GENERAL"
        case .misc: return "MISC"
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
        case .wordLanguage: return "Word Language"
        case .showHint: return "Show Hint"
        case .darkMode: return "Dark Mode"
        case .listOfAllWords: return "List of Words"
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

