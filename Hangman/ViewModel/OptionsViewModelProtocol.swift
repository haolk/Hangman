//
//  OptionsViewModelProtocol.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

protocol OptionsViewModelProtocol {
    func getType() -> SettingsOptions
    func setNewWordLanguage(at row: Int) -> Bool
    func getDataCount() -> Int
    func getDataText(at row: Int) -> String
}
