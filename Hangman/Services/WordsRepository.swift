//
//  WordsRepository.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 13/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case apiError
    case invalidResponse
    case decodeError
    case noData
}

final class WordsRepository {
    private var allWords = [Word]()
    private var randomWordDetails: WordDetails?
    private var lastRandomWordDetails: WordDetails?
    
    init() {
        if let jsonDataUrl = URL(string: Constants.jsonDataUrl) {
            var urlRequest = URLRequest(url: jsonDataUrl)
            urlRequest.setValue(Constants.apiSecretKey, forHTTPHeaderField: "secret-key")
            
            loadWordsFromWebAPI(with: urlRequest) { result in
                switch result {
                case .success(let jsonResult):
                    self.writeJsonInDocDirectory(jsonResult: jsonResult)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func getRandomWord() -> WordDetails {
        readJsonFromDocDirectory()
        if allWords.isEmpty {
            loadWordsFromAppBundle()
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
        
        readJsonFromDocDirectory()
        if allWords.isEmpty {
            loadWordsFromAppBundle()
        }
        
        if activeWordLangugage == WordLanguages.croatian.description {
            return allWords.map({ $0.hr })
        } else if activeWordLangugage == WordLanguages.english.description {
            return allWords.map({ $0.en })
        }
        
        return [WordDetails]()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func loadWordsFromAppBundle() {
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
    

    private func loadWordsFromWebAPI(with url: URLRequest, completion: @escaping (Result<[Word], RequestError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.apiError))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, !(200...299).contains(statusCode) {
                print("Status code: \(statusCode)")
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let decodedValues = try JSONDecoder().decode([Word].self, from: data)
                completion(.success(decodedValues))
            } catch  {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
        
    private func writeJsonInDocDirectory(jsonResult: [Word]) {
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("words.json")
            
            try JSONEncoder().encode(jsonResult).write(to: fileURL)
        } catch {
            print("Error in writeJsonInDocDirectory: \(error)")
        }
    }
    
    private func readJsonFromDocDirectory() {
        if self.allWords.count > 0 { return }
        
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("words.json")

            let data = try Data(contentsOf: fileURL)
            let jsonResult = try JSONDecoder().decode([Word].self, from: data)
            self.allWords = jsonResult
        } catch {
            print("Error in readJsonFromDocDirectory: \(error)")
        }
    }
    
}
