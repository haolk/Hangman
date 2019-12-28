//
//  OptionsView.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

protocol OptionsViewDelegate: AnyObject {
    func backToStartView()
}

class OptionsView: UIView {
    
    // MARK: - PROPERTIES
    
    private var backButton: UIButton!
    var titleLabel: UILabel!
    
    var optionsTableView: UITableView!
    
    weak var delegate: OptionsViewDelegate?
    
    // MARK: - INIT
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setup() {
        ThemeManager.addDarkModeObserver(to: self, selector: #selector(enableDarkMode))
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = Constants.backgroundColor
        
        enableDarkMode()
        addElementsOnView()
        setConstraintsForElements()
    }

    private func addElementsOnView() {
        backButton = UIButton()
        let backIconConfig = UIImage.SymbolConfiguration(pointSize: 26)
        let backIcon = UIImage(systemName: "arrowshape.turn.up.left.fill", withConfiguration: backIconConfig)
        backButton.setImage(backIcon, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = Constants.mainColor
        backButton.addTarget(self, action: #selector(backToStartView), for: .touchUpInside)
        addSubview(backButton)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.init(name: "Marker Felt", size: 26)
        titleLabel.textColor = Constants.mainColor
        titleLabel.textAlignment = .center
        //titleLabel.layer.borderColor = UIColor.black.cgColor
        //titleLabel.layer.borderWidth = 2
        addSubview(titleLabel)
        
        optionsTableView = UITableView(frame: frame, style: .grouped)
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        optionsTableView.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.reuseIdentifier)
        //optionsTableView.rowHeight = 50
        //optionsTableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: CGFloat.leastNormalMagnitude)))
        optionsTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 10))
        optionsTableView.tableHeaderView?.backgroundColor = Constants.backgroundColor
        //optionsTableView.sectionFooterHeight = 0
        addSubview(optionsTableView)
    }
        
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            backButton.leadingAnchor .constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -50),
            optionsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            optionsTableView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            optionsTableView.rightAnchor.constraint(equalTo: rightAnchor),
            optionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - SELECTORS METHODS
    
    @objc private func backToStartView() {
        delegate?.backToStartView()
    }
    
    @objc private func enableDarkMode() {
        overrideUserInterfaceStyle = GlobalSettings.darkMode ? .dark : .light
    }
    
}
