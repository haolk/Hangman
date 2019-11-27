//
//  SettingsViewController.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 25/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsDelegate {
    
    fileprivate lazy var settingsView: SettingsView = {
        let settingsView = SettingsView()
        settingsView.delegate = self
        return settingsView
    }()
    
    // MARK: - INIT
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TABLE ROW ACTION METHODS
    
    func backToStartView() {
        navigationController?.popViewController(animated: true)
    }
    
    func openWordLanguageVC() {
        print("openWordLanguageVC")
    }
    
    func openListOfAllWordsVC() {
        print("openListOfAllWordsVC")
    }
    
}
