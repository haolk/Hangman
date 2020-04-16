//
//  Button.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 13/04/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

@propertyWrapper
class Button {
    var wrappedValue: UIButton
    
    init(iconSize: CGFloat, iconSystemName: String) {
        self.wrappedValue = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(pointSize: iconSize)
        let icon = UIImage(systemName: iconSystemName, withConfiguration: iconConfig)
        wrappedValue.setImage(icon, for: .normal)
        wrappedValue.tintColor = Constants.Colors.mainColor
        configureButton()
    }
    
    init(borderWidth: CGFloat, cornerRadius: CGFloat, iconSize: CGFloat, iconSystemName: String, iconWeight: UIImage.SymbolWeight = .regular) {
        self.wrappedValue = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(pointSize: iconSize, weight: iconWeight)
        let icon = UIImage(systemName: iconSystemName, withConfiguration: iconConfig)
        wrappedValue.setImage(icon, for: .normal)
        wrappedValue.layer.borderWidth = borderWidth
        wrappedValue.layer.cornerRadius = cornerRadius
        wrappedValue.layer.borderColor = Constants.Colors.mainColor.cgColor
        configureButton()
    }
    
    private func configureButton() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
