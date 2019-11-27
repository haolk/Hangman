//
//  Word.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 05/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

public struct Word: Codable {
    var hr: Details
    var en: Details
}

public struct Details: Codable {
    var word: String
    var hint: String
}

extension Word: Equatable {
    
    public static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.en.word == rhs.en.word || lhs.hr.word == rhs.hr.word
    }
}
