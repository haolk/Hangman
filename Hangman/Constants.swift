//
//  Constants.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 02/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

enum Constants {
    static let LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    static let BLUE = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
    
    static let BACKGROUND_COLOR = UIColor.white
    
    static let FONT = "Marker Felt"
    
    static let HEIGHT_FOR_HEADER_IN_SECTION = CGFloat(40)
    
    #warning("localization")
    static var GameOver: String { get { "game over".localizedCapitalized } }
}

