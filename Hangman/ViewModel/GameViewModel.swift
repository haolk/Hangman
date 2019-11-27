//
//  GameViewModel.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 09/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

class GameViewModel: GameViewModelProtocol {
    let wordsRepository: WordsRepository
    
    // MARK: GameViewModel protocol
    
    var game: Game
    var score: Dynamic<String>
    var image: Dynamic<String>
    var answere: Dynamic<String>
    var hint: String
    var isFinished: Dynamic<Bool>
    
    var alertTitle: String = ""
    var alertMessage: String = ""
    
    func letterButtonTapped(_ letterButton: String) -> Bool {
        if(game.answere.contains(letterButton)) {
            correctLetterTapped(letterButton)
            return true
        } else {
            wrongLetterTapped()
            return false
        }
    }
    
    func newWord() {
        let newGame = self.refreshGame()
        self.game = newGame
        self.image = Dynamic(GameViewModel.imageFormatter(for: newGame))
        self.answere =  Dynamic(GameViewModel.answereFormatted(for: newGame))
        self.hint = newGame.hint
        self.isFinished = Dynamic(newGame.isFinished)
    }
    
    func checkIsGameFinished() {
        if(game.isFinished) {
            self.isFinished.value = true
        }
    }
    
    // MARK: INIT
    
    init(_ wordsRepository: WordsRepository, _ game: Game) {
        self.wordsRepository = wordsRepository
        self.game = game
        self.score = Dynamic(GameViewModel.scoreFormatted(for: game))
        self.image = Dynamic(GameViewModel.imageFormatter(for: game))
        self.answere =  Dynamic(GameViewModel.answereFormatted(for: game))
        self.hint = game.hint
        self.isFinished = Dynamic(game.isFinished)
    }
    
    // MARK: - PRIVATE
    
    fileprivate func refreshGame() -> Game {
        let word = wordsRepository.getRandomWord()
        print(word.en.word)
        
        let game = Game(score: self.game.score, answere: word.en.word.uppercased(), hint: word.en.hint)
        return game
    }
    
    fileprivate func updateScore(as amount: ScoreAmount) -> String {
        return GameViewModel.scoreFormatted(amount, for: game)
    }
    
    fileprivate func updateImage() -> String {
        return GameViewModel.imageFormatter(1, for: game)
    }
    
    fileprivate func correctLetterTapped(_ tappedLetter: String/*, _ letterButton: UIButton*/) {
        for (index, char) in game.answere.enumerated() where String(char) == tappedLetter {
            let myIndex = index * 2 //multiply with 2 because the space between letters - each space increase index of letter multiplied by 2
            
            let firstPartUpToTappedLetter = answere.value.prefix(myIndex)
            let secondPartAfterTappedLetter = answere.value.dropFirst(myIndex+1) // +1 to make place for tapped letter
            
            answere.value = firstPartUpToTappedLetter + tappedLetter + secondPartAfterTappedLetter
            score.value = updateScore(as: .rightLetter)
        }
        checkWholeWord()
    }
    
    fileprivate func wrongLetterTapped(){
        image.value = updateImage()
        score.value = updateScore(as: .wrongLetter)
        if game.isFinished {
            gameLost()
        }
    }
    
    fileprivate func checkWholeWord() {
        let answeredWord = answere.value.replacingOccurrences(of: " ", with: "")
        if game.answere == answeredWord {
            gameWin()
        }
    }
    
    fileprivate func gameWin() {
        game.isFinished = true
        score.value = updateScore(as: .wholeWord)
        alertTitle = "Nice job!"
        alertMessage = "You found the correct word."
    }
    
    fileprivate func gameLost() {
        score.value = updateScore(as: .gameOver)
        alertTitle = "Game Over!"
        alertMessage = "Better luck next time"
    }
    
    // MARK: - STRING UTILS
    
    fileprivate static func scoreFormatted(_ amount: ScoreAmount = .startAmount, for game: Game) -> String {
        return "Score: \(game.updateScore(for: amount.rawValue))"
    }
    
    fileprivate static func imageFormatter(_ amount: Int = 0, for game: Game) -> String {
        return "Hangman-\(game.updateImage(for: amount))"
    }
    
    fileprivate static func answereFormatted(for game: Game) -> String {
        return String.init(repeating: "_ ", count: game.answere.count).trimmingCharacters(in: .whitespaces)
    }
    
}
