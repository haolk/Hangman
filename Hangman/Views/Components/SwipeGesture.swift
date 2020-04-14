//
//  SwipeGesture.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 14/04/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

@propertyWrapper
class SwipeGesture {
    var wrappedValue: UISwipeGestureRecognizer
    
    init(swipteDirection: UISwipeGestureRecognizer.Direction) {
        self.wrappedValue = UISwipeGestureRecognizer()
        wrappedValue.direction = swipteDirection
    }
    
}
