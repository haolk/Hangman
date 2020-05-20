//
//  UserInfoHeader.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

final class UserInfoHeader: UIView {
    
    // MARK: - PROPERTIES
    
    @ImageView(imageName: "myPicture", isClipsToBounds: true)
    var profileImageView: UIImageView
    
    @Label(text: "Hrvoje Vuković", ofSize: .medium)
    var usernameLabel: UILabel
    
    @Label(text: "vukovic.hrvoje@icloud.com", ofSize: .small, textColor: .gray)
    var emailLabel: UILabel
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        let profileImageDimension: CGFloat = 60
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        
        backgroundColor = Constants.Colors.backgroundColor
        
        addElementsOnView()
        setConstraintsForElements(profileImageDimension)
    }
    
    private func addElementsOnView() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(emailLabel)
    }
    
    private func setConstraintsForElements(_ profileImageDimension: CGFloat) {
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension),
            usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10),
            usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10),
            emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        ])
    }
    
}
