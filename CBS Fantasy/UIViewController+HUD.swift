//
//  UIViewController+HUD.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/26/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showHUD() {
        if isViewLoaded {
            DispatchQueue.main.async { [unowned self] in
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.bezelView.color = UIColor(white: 0, alpha: 0.8)
                hud.bezelView.style = .solidColor
                hud.contentColor = UIColor(white: 0.6, alpha: 0.8)
                hud.backgroundColor = UIColor(white: 0.8, alpha: 0.1)
            }
        }
    }
    
    func hideHUD() {
        if isViewLoaded {
            DispatchQueue.main.async { [unowned self] in
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}
