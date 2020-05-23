//
//  PopupView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 13/05/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

class PopupView: UIView {
    
    // MARK: - ACTION CLOSURES
    
    var onClosePopup: () -> Void = {}
    
    // MARK: - PROPERTIES
    
    @Label(text: "SCORING SYSTEM", font: .appFont, fontSize: .large, numberOfLines: 1, textColor: Constants.Colors.mainColor)
    var titleLabel: UILabel
    
    @Label(text: Constants.scoringSystemText, font: .appFont, fontSize: .medium, numberOfLines: 4, textColor: Constants.Colors.mainColor)
    var textLabel: UILabel
    
    @Button(type: .close)
    var okButton: UIButton
    
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
        okButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
    }
    
    private func addElementsOnView() {
        popupView = UIView()
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.backgroundColor = Constants.Colors.backgroundColor
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        addSubview(popupView)

        popupView.addSubview(titleLabel)
        popupView.addSubview(textLabel)
        popupView.addSubview(okButton)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: 280),
            popupView.heightAnchor.constraint(equalToConstant: 200),
            popupView.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: popupView.layoutMarginsGuide.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textLabel.widthAnchor.constraint(equalTo: popupView.layoutMarginsGuide.widthAnchor, multiplier: 0.8),
            textLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            
            okButton.bottomAnchor.constraint(equalTo: popupView.layoutMarginsGuide.bottomAnchor, constant: -5),
            okButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor)
        ])
    }
    
    // MARK: - SELECTORS METHODS
    
    @objc private func closePopup() {
        onClosePopup()
    }
    
}
