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
    
    func createGameViewModel() -> GameViewModel {
        let game = startGame()
        return GameViewModel(wordsRepository, game)
    }
    
    func createSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(wordsRepository: wordsRepository)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func startGame() -> Game {
        let wordDetails = wordsRepository.getRandomWord()
        print(wordDetails.word)
        let bestScore = GlobalSettings.bestScore
        
        let game = Game(bestScore: bestScore, answere: wordDetails.word.uppercased(), hint: wordDetails.hint)
        return game
    }
    
}
