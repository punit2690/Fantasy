//
//  FrontsViewController.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation
import UIKit

protocol FrontsViewControllerDelegate: class {
    func didTapHamburgerMenu()
}

class FrontsViewController: UIViewController {
    
    weak var delegate: FrontsViewControllerDelegate?
    fileprivate var viewModel: FrontsViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewModel = FrontsViewModel(delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewModel = FrontsViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapHamburgerMenu(_ sender: Any) {
        delegate?.didTapHamburgerMenu()
    }
}

extension FrontsViewController: FrontsViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension FrontsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForCard(at: indexPath.row, for: tableView)
    }
}
