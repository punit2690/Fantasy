//
//  MenuViewController.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation
import UIKit

protocol MenuViewControllerDelegate: class {
    func didSelectSport(sport: SPORT)
}
    
class MenuViewController: UITableViewController {
    
    weak var delegate: MenuViewControllerDelegate?

    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            case 0:
                delegate?.didSelectSport(sport: .Baseball)
            case 1:
                delegate?.didSelectSport(sport: .Football)
            case 2:
                delegate?.didSelectSport(sport: .Basketball)
            case 3:
                delegate?.didSelectSport(sport: .Hockey)
            default:
                break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


