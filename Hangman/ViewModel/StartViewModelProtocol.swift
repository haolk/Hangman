//
//  StartViewModelProtocol.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 09/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

protocol StartViewModelProtocol {
    func createGameViewModel() -> GameViewModel
    func createSettingsViewModel() -> SettingsViewModel
}
