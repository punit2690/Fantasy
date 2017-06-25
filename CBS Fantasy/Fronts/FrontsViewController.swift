//
//  FrontsViewController.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation
import UIKit

protocol FrontsViewControllerDelegate {
    func didTapHamburgerMenu()
}

class FrontsViewController: UIViewController {
    
    var delegate: FrontsViewControllerDelegate?
    fileprivate let viewModel = FrontsViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapHamburgerMenu(_ sender: Any) {
        delegate?.didTapHamburgerMenu()
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
