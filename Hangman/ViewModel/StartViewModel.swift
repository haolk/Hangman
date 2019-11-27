//
//  StartViewModel.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 09/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

class StartViewModel: StartViewModelProtocol {
    
    // MARK: - StartViewModel Protocol
    
    let wordsRepository: WordsRepository
    
    func startGame() -> Game {
        let word = wordsRepository.getRandomWord()
        print(word.en.word)
        
        let game = Game(answere: word.en.word.uppercased(), hint: word.en.hint)
        return game
    }
    
    // MARK: - INIT
    
    init(_ wordsRepository: WordsRepository) {
        self.wordsRepository = wordsRepository
    }
    
}
