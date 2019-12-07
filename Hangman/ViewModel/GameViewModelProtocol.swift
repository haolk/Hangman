//
//  GameViewModelProtocol.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 05/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

protocol GameViewModelProtocol {
    var game: Game { get }
    var score: Dynamic<String> { get }
    var bestScore: Dynamic<String> { get }
    var image: Dynamic<String> { get }
    var answere: Dynamic<String> { get }
    var hint: String { get }
    var isUseShowHint: Dynamic<Bool> { get }
    var isFinished: Dynamic<Bool> { get }
    
    var alertTitle: String { get }
    var alertMessage: String { get }
    
    func isCorrectLetterTapped(_ letterButton: String) -> Bool
    func newWord()
    func checkIsGameFinished()
    func checkWeHaveNewBestScore()
}
