//
//  Switch.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 13/04/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

@propertyWrapper
class Switch {
    var wrappedValue: UISwitch
    
    init() {
        self.wrappedValue = UISwitch()
        configureSwitch()
    }
    
    private func configureSwitch() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        wrappedValue.onTintColor = Constants.Colors.mainColor
    }
}
