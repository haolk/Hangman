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
    
    var game: Game
    var score: Dynamic<String>
    var bestScore: Dynamic<String>
    var image: Dynamic<String>
    var answere: Dynamic<String>
    var hint: String
    var isFinished: Dynamic<Bool>
    var isUseShowHint: Dynamic<Bool>
    
    var alertTitle: String = ""
    var alertMessage: String = ""
    
    init(_ wordsRepository: WordsRepository, _ game: Game) {
        self.wordsRepository = wordsRepository
        self.game = game
        self.score = Dynamic(GameViewModel.scoreFormatted(for: game))
        self.bestScore = Dynamic(GameViewModel.bestScoreFormatted(for: game))
        self.image = Dynamic(GameViewModel.imageFormatter(for: game))
        self.answere =  Dynamic(GameViewModel.answereFormatted(for: game))
        self.hint = game.hint
        self.isFinished = Dynamic(game.isFinished)
        self.isUseShowHint = Dynamic(GameViewModel.checkIsUseShowHint())
    }
    
    // MARK: - PROTOCOL METHODS
    
    func isCorrectLetterTapped(_ letterButton: String) -> Bool {
        if(game.answere.contains(letterButton)) {
            correctLetterTapped(letterButton)
            return true
        }
        wrongLetterTapped()
        return false
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
        if game.isFinished {
            self.isFinished.value = true
        }
    }

    func checkWeHaveNewBestScore() {
        if game.weHaveNewBestScore {
            //save new best score in user defaults
            GlobalSettings.bestScore = game.bestScore
            
            //update best score label
            bestScore.value = GameViewModel.bestScoreFormatted(for: game)
            
            //to prevent updating best score label every time ie. update only if we have new best score
            game.weHaveNewBestScore = false
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func refreshGame() -> Game {
        let wordDetails = wordsRepository.getRandomWord()
        print(wordDetails.word)
        
        let game = Game(score: self.game.score, bestScore: self.game.bestScore, answere: wordDetails.word.uppercased(), hint: wordDetails.hint)
        return game
    }
    
    private func correctLetterTapped(_ tappedLetter: String) {
        for (index, char) in game.answere.enumerated() where String(char) == tappedLetter {
            let myIndex = index * 2 //multiply with 2 because the space between letters - each space increase index of letter multiplied by 2
            
            let firstPartUpToTappedLetter = answere.value.prefix(myIndex)
            let secondPartAfterTappedLetter = answere.value.dropFirst(myIndex+1) // +1 to make place for tapped letter
            
            answere.value = firstPartUpToTappedLetter + tappedLetter + secondPartAfterTappedLetter
            score.value = updateScore(as: .rightLetter)
        }
        checkWholeWord()
    }
    
    private func wrongLetterTapped(){
        image.value = updateImage()
        score.value = updateScore(as: .wrongLetter)
        if game.isFinished {
            gameLost()
        }
    }
    
    private func checkWholeWord() {
        let answeredWord = answere.value.replacingOccurrences(of: " ", with: "")
        if game.answere == answeredWord {
            gameWin()
        }
    }
    
    private func gameWin() {
        game.isFinished = true
        score.value = updateScore(as: .wholeWord)
        alertTitle = "Nice job!"
        alertMessage = "You found the correct word."
    }
    
    private func gameLost() {
        score.value = updateScore(as: .gameOver)
        alertTitle = "\(Constants.GameOver)! \nHidden word: \(game.answere)!"
        alertMessage = "Better luck next time"
    }
    
    private func updateScore(as amount: ScoreAmount) -> String {
        return GameViewModel.scoreFormatted(amount, for: game)
    }
    
    private func updateImage() -> String {
        return GameViewModel.imageFormatter(1, for: game)
    }
    
    // MARK: - PRIVATE STATIC METHODS
    
    private static func checkIsUseShowHint() -> Bool {
        return GlobalSettings.useShowHint
    }
    
    // MARK: - STRING UTILS
    
    private static func scoreFormatted(_ amount: ScoreAmount = .startAmount, for game: Game) -> String {
        return "Score: \(game.updateScore(for: amount.rawValue))"
    }
    
    private static func bestScoreFormatted(for game: Game) -> String {
        return "Best: \(game.bestScore)"
    }
    
    private static func imageFormatter(_ amount: Int = 0, for game: Game) -> String {
        return "Hangman-\(game.updateImage(for: amount))"
    }
    
    private static func answereFormatted(for game: Game) -> String {
        return String.init(repeating: "_ ", count: game.answere.count).trimmingCharacters(in: .whitespaces)
    }
    
}
