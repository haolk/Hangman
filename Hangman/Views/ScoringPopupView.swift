//
//  PopupView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 13/05/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

class ScoringPopupView: UIView {
    
    // MARK: - ACTION CLOSURES
    
    var onClosePopup: () -> Void = {}
    
    // MARK: - PROPERTIES
    
    @Label(text: "SCORING SYSTEM", fontSize: .large)
    var titleLabel: UILabel
    
    @Label(text: "RIGHT LETTER", fontSize: .medium, textAlignment: .left)
    var row1LeftLabel: UILabel
    
    @Label(text: "+1", fontSize: .medium, textAlignment: .right)
    var row1RightLabel: UILabel
    
    @Label(text: "WRONG LETTER", fontSize: .medium, textAlignment: .left)
    var row2LeftLabel: UILabel
    
    @Label(text: "-1", fontSize: .medium, textAlignment: .right)
    var row2RightLabel: UILabel
    
    @Label(text: "GAME WIN", fontSize: .medium, textAlignment: .left)
    var row3LeftLabel: UILabel
    
    @Label(text: "+10", fontSize: .medium, textAlignment: .right)
    var row3RightLabel: UILabel
    
    @Label(text: "GAME LOST", fontSize: .medium, textAlignment: .left)
    var row4LeftLabel: UILabel
    
    @Label(text: "-5", fontSize: .medium, textAlignment: .right)
    var row4RightLabel: UILabel
    
    @Button(type: .close)
    var closeButton: UIButton
    
    var popupView = UIView()

    // MARK: - INIT
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        overrideUserInterfaceStyle = .light
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        addTargetOnElements()
        addElementsOnView()
        setConstraintsForElements()
    }
    
    private func addTargetOnElements() {
        closeButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
    }
    
    private func addElementsOnView() {
        popupView = UIView()
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.backgroundColor = Constants.Colors.backgroundColor
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        addSubview(popupView)

        popupView.addSubview(titleLabel)
        popupView.addSubview(row1LeftLabel)
        popupView.addSubview(row1RightLabel)
        popupView.addSubview(row2LeftLabel)
        popupView.addSubview(row2RightLabel)
        popupView.addSubview(row3LeftLabel)
        popupView.addSubview(row3RightLabel)
        popupView.addSubview(row4LeftLabel)
        popupView.addSubview(row4RightLabel)
        popupView.addSubview(closeButton)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: 280),
            popupView.heightAnchor.constraint(equalToConstant: 200),
            popupView.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: popupView.layoutMarginsGuide.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            
            row1LeftLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            row1LeftLabel.leadingAnchor.constraint(equalTo: popupView.layoutMarginsGuide.leadingAnchor, constant: 40),
            
            row1RightLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            row1RightLabel.trailingAnchor.constraint(equalTo: popupView.layoutMarginsGuide.trailingAnchor, constant: -40),
            
            row2LeftLabel.topAnchor.constraint(equalTo: row1LeftLabel.bottomAnchor, constant: 5),
            row2LeftLabel.leadingAnchor.constraint(equalTo: popupView.layoutMarginsGuide.leadingAnchor, constant: 40),

            row2RightLabel.topAnchor.constraint(equalTo: row1RightLabel.bottomAnchor, constant: 5),
            row2RightLabel.trailingAnchor.constraint(equalTo: popupView.layoutMarginsGuide.trailingAnchor, constant: -40),

            row3LeftLabel.topAnchor.constraint(equalTo: row2LeftLabel.bottomAnchor, constant: 5),
            row3LeftLabel.leadingAnchor.constraint(equalTo: popupView.layoutMarginsGuide.leadingAnchor, constant: 40),

            row3RightLabel.topAnchor.constraint(equalTo: row2RightLabel.bottomAnchor, constant: 5),
            row3RightLabel.trailingAnchor.constraint(equalTo: popupView.layoutMarginsGuide.trailingAnchor, constant: -40),
            
            row4LeftLabel.topAnchor.constraint(equalTo: row3LeftLabel.bottomAnchor, constant: 5),
            row4LeftLabel.leadingAnchor.constraint(equalTo: popupView.layoutMarginsGuide.leadingAnchor, constant: 40),

            row4RightLabel.topAnchor.constraint(equalTo: row3RightLabel.bottomAnchor, constant: 5),
            row4RightLabel.trailingAnchor.constraint(equalTo: popupView.layoutMarginsGuide.trailingAnchor, constant: -40),
            
            closeButton.bottomAnchor.constraint(equalTo: popupView.layoutMarginsGuide.bottomAnchor),
            closeButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor)
        ])
    }
    
    // MARK: - SELECTORS METHODS
    
    @objc private func closePopup() {
        onClosePopup()
    }
    
}
