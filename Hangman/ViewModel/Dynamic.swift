//
//  Dynamic.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 18/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import Foundation

final class Dynamic<T> {
    typealias Listener = (T) -> ()
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
