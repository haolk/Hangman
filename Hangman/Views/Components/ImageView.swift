//
//  ImageView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 13/04/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

@propertyWrapper
class ImageView {
    var wrappedValue: UIImageView
    
    init() {
        self.wrappedValue = UIImageView()
        configureImageView()
    }
    
    init(imageName: String, isClipsToBounds: Bool = false) {
        self.wrappedValue = UIImageView()
        wrappedValue.image = UIImage(named: imageName)
        wrappedValue.clipsToBounds = isClipsToBounds
        configureImageView()
    }
    
    private func configureImageView() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        wrappedValue.contentMode = .scaleAspectFill
    }
}
