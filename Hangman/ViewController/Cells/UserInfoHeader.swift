//
//  UserInfoHeader.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class UserInfoHeader: UIView {
    
    // MARK: - PROPERTIES
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "myPicture")
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hrvoje"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hrvoje0099@gmail.com"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
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
        
        backgroundColor = Constants.backgroundColor
        
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
