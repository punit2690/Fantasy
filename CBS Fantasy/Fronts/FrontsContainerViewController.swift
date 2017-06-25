//
//  FrontsContainerViewController.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation
import UIKit

class FrontsContainerViewController: UIViewController {
    
    @IBOutlet weak var sideMenuViewContainer: UIView!
    @IBOutlet weak var frontsViewContainer: UIView!
    @IBOutlet weak var sideMenuContainerWidth: NSLayoutConstraint!
    weak var frontsViewController: FrontsViewController?
    weak var menuViewController: MenuViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: self)
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
            
            case "embedFronts":
                frontsViewController = (segue.destination  as! UINavigationController).topViewController as? FrontsViewController
                frontsViewController?.delegate = self
                break
            
            case "embedSideMenu":
                menuViewController = (segue.destination as! UINavigationController).topViewController as? MenuViewController
                break
            
            default:
                break
        }
    }
    
    fileprivate func toggleMenu() {
        if sideMenuContainerWidth.constant != 200 {
            self.sideMenuContainerWidth.constant = 200
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            self.sideMenuContainerWidth.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
}

extension FrontsContainerViewController: FrontsViewControllerDelegate {
    
    func didTapHamburgerMenu() {
        toggleMenu()
    }
}
