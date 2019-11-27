//
//  WordsRepository.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 13/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

class WordsRepository {
    
    fileprivate var allWords = [Word]()
    fileprivate var randomWord: Word?
    fileprivate var lastRandomWord: Word?
    
    func getRandomWord() -> Word {
        if allWords.isEmpty {
            loadWords()
        }
        randomWord = allWords.randomElement()
        checkWordValidation()
        return randomWord!
    }
    
    // MARK: - PRIVATE METHODS
    
    fileprivate func loadWords() {
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonResult = try JSONDecoder().decode([Word].self, from: jsonData)
                allWords = jsonResult
                //print(allWords)
            } catch {
                allWords = [Word(hr: Details(word: "", hint: "Ups, greška!"), en: Details(word: "", hint: "Oops, error!"))]
                print("Error with parsing JSON: \(error)")
            }
        }
    }
    
    fileprivate func checkWordValidation() { //to prevent repetition of the same word twice in a row
        if randomWord == lastRandomWord {
            _ = getRandomWord()
        } else {
            lastRandomWord = randomWord
        }
    }
}
