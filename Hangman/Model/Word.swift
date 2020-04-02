//
//  Word.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 05/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

struct Word: Codable {
    let hr: WordDetails
    let en: WordDetails
}

struct WordDetails: Codable {
    let word: String
    let hint: String
}

enum WordLanguages: Int, CaseIterable {
    case croatian
    case english
    
    var description: String {
        switch self {
        case .croatian: return "Croatian"
        case .english: return "English"
        }
    }
}

extension WordDetails: Equatable {
    
    public static func == (lhs: WordDetails, rhs: WordDetails) -> Bool {
        return lhs.word == rhs.word && lhs.hint == rhs.hint
    }
}
