//
//  Theme.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 09/12/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

struct ThemeManager {
    
    static func enableDarkMode() {
        GlobalSettings.darkMode = true
        NotificationCenter.default.post(name: .darkModeHasChanged, object: nil)
    }
    
    static func disableDarkMode() {
        GlobalSettings.darkMode = false
        NotificationCenter.default.post(name: .darkModeHasChanged, object: nil)
    }
    
    static func addDarkModeObserver(to observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: .darkModeHasChanged, object: nil)
    }
    
}

extension Notification.Name {
    static let darkModeHasChanged = Notification.Name("darkModeHasChanged")
}
