//
//  PopupViewController.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 13/05/2020.
//  Copyright © 2020 Hrvoje Vuković. All rights reserved.
//

import UIKit

class ScoringViewController: UIViewController {

    // MARK: - PROPERTIES
    
    private lazy var scoringPopupView: ScoringPopupView = {
        let scoringPopupView = ScoringPopupView()
        return scoringPopupView
    }()
    
    // MARK: - INIT
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = scoringPopupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        setViewClosures()
    }
    
    // MARK: - VIEW CLOSURES
    
    private func setViewClosures() {
        scoringPopupView.onClosePopup = { [weak self] in
            self?.removeAnimate()
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.scoringPopupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.scoringPopupView.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished) {
                self.willMove(toParent: nil)
                self.scoringPopupView.removeFromSuperview()
                self.removeFromParent()
            }
        });
    }
    
}
