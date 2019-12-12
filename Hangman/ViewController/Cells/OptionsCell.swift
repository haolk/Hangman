//
//  OptionsCell.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class OptionsCell: UITableViewCell {
    static let reuseIdentifier = "OptionsCell"
    
    // MARK: - PROPERTIES
    
    let labelLeft: UILabel = {
        let labelLeft = UILabel()
        labelLeft.translatesAutoresizingMaskIntoConstraints = false
        labelLeft.textAlignment = .left
        labelLeft.baselineAdjustment = .alignCenters
        return labelLeft
    }()
    
    let labelRight: UILabel = {
        let labelRight = UILabel()
        labelRight.translatesAutoresizingMaskIntoConstraints = false
        labelRight.textAlignment = .right
        labelRight.baselineAdjustment = .alignCenters
        return labelRight
    }()
    
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
