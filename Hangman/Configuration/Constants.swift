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
    
    enum FontSizes: CGFloat {
        case small      = 14
        case medium     = 16
        case large      = 26
        case xlarge     = 55
    }
    
    enum ButtonSizes: CGFloat {
        case small      = 26
        case medium     = 40
        case large      = 60
    }
    
    enum SFSymbols: String {
        case play       = "play.fill"
        case settings   = "gear"
        case back       = "arrowshape.turn.up.left.fill"
        case question   = "questionmark.circle"
    }
    
    enum LocalizedString {
        static let gameOver                 = NSLocalizedString("GAME_OVER", comment: "")
        static let niceJob                  = NSLocalizedString("NICE_JOB", comment: "")
        static let youFoundTheCorrectWord   = NSLocalizedString("YOU_FOUND_THE_CORRECT_WORD", comment: "")
        static let hiddenWord               = NSLocalizedString("HIDDEN_WORD", comment: "")
        static let betterLuckNextTime       = NSLocalizedString("BETTER_LUCK_NEXT_TIME", comment: "")
        static let score                    = NSLocalizedString("SCORE", comment: "")
        static let best                     = NSLocalizedString("BEST", comment: "")
        static let hangman                  = NSLocalizedString("HANGMAN", comment: "")
        static let general                  = NSLocalizedString("GENERAL", comment: "")
        static let misc                     = NSLocalizedString("MISC", comment: "")
        static let wordLanguage             = NSLocalizedString("WORD_LANGUAGE", comment: "")
        static let showHint                 = NSLocalizedString("SHOW_HINT", comment: "")
        static let darkMode                 = NSLocalizedString("DARK_MODE", comment: "")
        static let listOfWords              = NSLocalizedString("LIST_OF_WORDS", comment: "")
        static let croatian                 = NSLocalizedString("CROATIAN", comment: "")
        static let english                  = NSLocalizedString("ENGLISH", comment: "")
        static let settings                 = NSLocalizedString("SETTINGS", comment: "")
        static let selectWordLanguage       = NSLocalizedString("SELECT_WORD_LANGUAGE", comment: "")
        static let newGame                  = NSLocalizedString("NEW_GAME", comment: "")
        static let error                    = NSLocalizedString("ERROR", comment: "")
    }
    
}
