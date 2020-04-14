//
//  OptionsCell.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

final class OptionsCell: UITableViewCell {
    static let reuseIdentifier = "OptionsCell"
    
    // MARK: - PROPERTIES
    
    @Label(textAlignment: .left)
    var labelLeft: UILabel
    
    @Label(textAlignment: .right)
    var labelRight: UILabel
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemnted")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        selectionStyle = .none
        
        addElementsOnView()
        setConstraintsForElements()
    }
    
    private func addElementsOnView() {
        addSubview(labelLeft)
        addSubview(labelRight)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            labelLeft.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 5),
            labelLeft.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -10),
            labelLeft.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            labelRight.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -5),
            labelRight.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -10),
            labelRight.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor)
        ])
    }
    
}
