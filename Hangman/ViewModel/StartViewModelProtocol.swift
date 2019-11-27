//
//  StartViewModelProtocol.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 09/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

protocol StartViewModelProtocol {
    var wordsRepository: WordsRepository { get }
    
    func startGame() -> Game
}
