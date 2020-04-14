//
//  StackView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 14/04/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

@propertyWrapper
class StackView {
    var wrappedValue: UIStackView
    
    init(spacing: CGFloat) {
        self.wrappedValue = UIStackView()
        wrappedValue.spacing = spacing
        configureStackView()
    }
    
    private func configureStackView() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        wrappedValue.distribution = .fillEqually
        wrappedValue.axis = .horizontal
    }
}
