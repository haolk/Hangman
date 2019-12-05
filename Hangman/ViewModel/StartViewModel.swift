//
//  StartViewModel.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 09/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

struct StartViewModel: StartViewModelProtocol {
    
    let wordsRepository: WordsRepository
    
    // MARK: - PROTOCOL METHODS
    
    func startGame() -> Game {
        let wordDetails = wordsRepository.getRandomWord()
        print(wordDetails.word)
        
        let game = Game(answere: wordDetails.word.uppercased(), hint: wordDetails.hint)
        return game
    }
    
}
