//
//  Label.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 07/04/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

@propertyWrapper
class Label {
    var wrappedValue: UILabel
    
    init(textAlignment: NSTextAlignment) {
        self.wrappedValue = UILabel()
        wrappedValue.textAlignment = textAlignment
        configureLabel()
    }
    
    init(text: String, ofSize: CGFloat, textColor: UIColor = .label) {
        self.wrappedValue = UILabel()
        wrappedValue.text = text
        wrappedValue.font = UIFont.systemFont(ofSize: ofSize)
        wrappedValue.textColor = textColor
        configureLabel()
    }
    
    init(ofSize: CGFloat, textAlignment: NSTextAlignment, text: String = "", textColor: UIColor = Constants.Colors.mainColor) {
        self.wrappedValue = UILabel()
        wrappedValue.text = text
        wrappedValue.font = UIFont.init(name: Constants.font, size: ofSize)
        wrappedValue.textAlignment = textAlignment
        wrappedValue.textColor = textColor
        configureLabel()
    }
    
    private func configureLabel() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
