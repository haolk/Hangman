//
//  Game.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 09/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

enum ScoreAmount: Int {
    case startAmount    = 0
    case rightLetter    = 1
    case wrongLetter    = -1
    case gameOver       = -5
    case wholeWord      = 10
}

class Game {
    var score: Int
    var imageCount: Int = 0
    var answere: String
    var hint: String
    
    var isUseShowHint: Bool = false
    var isFinished: Bool = false
    
    init(score: Int = 0, answere: String, hint: String) {
        self.score = score
        self.answere = answere
        self.hint = hint
    }
    
    func updateScore(for amount: Int) -> Int {
        score += amount
        return score
    }
    
    func updateImage(for amount: Int) -> Int {
        imageCount += amount
        
        if imageCount > 6 {     //game over - player lost all lives
            isFinished = true
        }
        
        return imageCount
    }
    
}
