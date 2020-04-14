//
//  GlobalSettings.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 05/12/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

enum GlobalSettings {
    @UserDefault(key: "useShowHint", defaultValue: false)
    static var useShowHint: Bool
    
    @UserDefault(key: "wordLanguage", defaultValue: WordLanguages.english.description)
    static var wordLanguage: String
    
    @UserDefault(key: "bestScore", defaultValue: 0)
    static var bestScore: Int
    
    @UserDefault(key: "darkMode", defaultValue: UIScreen.main.traitCollection.userInterfaceStyle == .light ? false : true)
    static var darkMode: Bool
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
