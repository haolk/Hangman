//
//  SettingsViewModelProtocol.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

protocol SettingsViewModelProtocol {
    func getNumberOfOptionsInSection(_ section: Int) -> Int
    func getOptionForSection(at indexPath: IndexPath) -> SettingsOptions
    func getSectionTitle(_ section: Int) -> String
    func getSectionCount() -> Int
    func createOptionsViewModel(_ type: SettingsOptions) -> OptionsViewModel
}
