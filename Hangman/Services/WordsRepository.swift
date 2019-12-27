//
//  WordsRepository.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 13/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

class WordsRepository {
    
    private var allWords = [Word]()
    private var randomWordDetails: WordDetails?
    private var lastRandomWordDetails: WordDetails?
    
    func getRandomWord() -> WordDetails {
        if allWords.isEmpty {
            loadWords()
        }
        
        guard let activeWordsAndHints = getActiveWordsAndHints() else {
            return WordDetails(word: "", hint: "")
        }
        
        randomWordDetails = activeWordsAndHints.filter { $0 != lastRandomWordDetails }.randomElement()
        lastRandomWordDetails = randomWordDetails
        
        return randomWordDetails ?? WordDetails(word: "", hint: "")
    }
    
    func getActiveWordsAndHints() -> [WordDetails]? {
        let activeWordLangugage = GlobalSettings.wordLanguage
        
        if allWords.isEmpty {
            loadWords()
        }
        
        if activeWordLangugage == WordLanguages.croatian.description {
            return allWords.map({ $0.hr })
        } else if activeWordLangugage == WordLanguages.english.description {
            return allWords.map({ $0.en })
        }
        
        return [WordDetails]()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func loadWords() {
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonResult = try JSONDecoder().decode([Word].self, from: jsonData)
                allWords = jsonResult
            } catch {
                allWords = [Word(hr: WordDetails(word: "", hint: "Ups, greška!"), en: WordDetails(word: "", hint: "Oops, error!"))]
                print("Error with parsing JSON: \(error)")
            }
        }
    }
    
}
