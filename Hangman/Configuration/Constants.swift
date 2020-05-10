//
//  Constants.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 02/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

enum Constants {
    static let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    static let font = "Marker Felt"
    
    static let jsonDataUrl  = "https://api.jsonbin.io/b/5e9cc3d75fa47104cea3869a/latest"        //private
    static let apiSecretKey = "$2b$10$xXkdXsdpu2ZGyszl30H82eVmRmz5uGR/HqIdb/gi84TQJCKSXLiM."
    
    enum Colors {
        static let mainColor        = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        static let backgroundColor  = UIColor.systemBackground
    }
    
    enum FontSizes {
        static let small: CGFloat   = 14
        static let medium: CGFloat  = 16
        static let large: CGFloat   = 26
        static let xlarge: CGFloat  = 55
    }
    
    enum ButtonSizes {
        static let small: CGFloat   = 26
        static let medium: CGFloat  = 40
        static let large: CGFloat   = 50
    }
    
    enum SFSymbols {
        static let play     = "play.fill"
        static let settings = "gear"
        static let back     = "arrowshape.turn.up.left.fill"
    }
    
}


/*
 "play.fill"    - play
 gear           - Settings
 "arrowshape.turn.up.left.fill"     - back
 */
