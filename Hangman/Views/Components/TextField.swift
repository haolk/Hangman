//
//  TextField.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 14/04/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

@propertyWrapper
class TextField {
    var wrappedValue: UITextField
    
    init(fontSize: Constants.FontSizes) {
        self.wrappedValue = UITextField()
        wrappedValue.font = UIFont.init(name: Constants.font, size: fontSize.rawValue)
        configureTextField()
    }
    
    private func configureTextField() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        wrappedValue.textAlignment = .center
        wrappedValue.isUserInteractionEnabled = false
    }
}
