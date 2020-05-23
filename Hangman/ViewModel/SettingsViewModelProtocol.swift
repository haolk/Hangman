//
//  SettingsViewModelProtocol.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

protocol SettingsViewModelProtocol {
    func getNumberOfOptions(inSection section: Int) -> Int
    func getOptionForSection(at indexPath: IndexPath) -> SettingsOptions
    func getSectionTitle(in section: Int) -> String
    func getSectionCount() -> Int
    func createOptionsViewModel(ofType type: SettingsOptions) -> OptionsViewModel
}
