//
//  OptionsViewController.swift
//  Hangman
//
//  Created by Hrvoje Vuković on 30/11/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController, OptionsDelegate {
    
    private var optionsViewModel: OptionsViewModelProtocol
    
    private lazy var optionsView: OptionsView = {
        let optionsView = OptionsView()
        optionsView.delegate = self
        optionsView.optionsTableView.delegate = self
        optionsView.optionsTableView.dataSource = self
        return optionsView
    }()
    
    // MARK: - INIT
    
    init(viewModel: OptionsViewModelProtocol) {
        self.optionsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = optionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - TABLE ROW ACTION METHODS
    
    func backToStartView() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension OptionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsViewModel.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCell.reuseIdentifier, for: indexPath) as? OptionsCell {
            
            let cellType = optionsViewModel.getType()
            let cellDataText = optionsViewModel.getDataText(at: indexPath.row)
            
            switch cellType {
            case .wordLanguage:
                cell.labelLeft.text = cellDataText
                cell.accessoryType = GlobalSettings.wordLanguage == cellDataText ? .checkmark : .none
            case .listOfAllWords:
                let cellDataSplited = cellDataText.split(separator: "-")
                cell.labelLeft.text = String(cellDataSplited[0]).lowercased()
                cell.labelRight.text = String(cellDataSplited[1]).lowercased()
            default:
                cell.labelLeft.text = "ERROR"
            }
            
            return cell

        } else {
            fatalError("Unknown identifier")
        }
    }
    
}

extension OptionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.HEIGHT_FOR_HEADER_IN_SECTION
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if optionsViewModel.setNewWordLanguage(at: indexPath.row) {
            optionsView.optionsTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            optionsView.optionsTableView.reloadData()
        }
    }
    
}
