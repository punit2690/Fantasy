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
        
        switch indexPath.section {
            case 0:
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
                break
            case 1:
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let webVC = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                
                switch indexPath.row {
                    case 0:
                        webVC.urlString = "https://www.fantasypros.com/mlb/rankings/ros-overall.php?partner=cbs_mlb_ecr_ros"
                        break
                    
                    case 1:
                        webVC.urlString = "https://www.fantasypros.com/mlb/myplaybook/baseball-lineup-assistant.php?partner=cbs_mlb_lineup"
                        break
                    
                    case 2:
                        webVC.urlString = "https://www.fantasypros.com/mlb/myplaybook/baseball-waiver-wire-assistant.php?partner=cbs_mlb_waiver"
                        break
                    
                    case 3:
                        webVC.urlString = "https://www.fantasypros.com/mlb/myplaybook/baseball-league-analyzer.php?partner=cbs_mlb_lganalyzer"
                        break
                    
                    case 4:
                        webVC.urlString = "https://www.fantasypros.com/mlb/myplaybook/baseball-trade-analyzer.php"
                        break
                    
                    default:
                        break
                    }
                    self.present(webVC, animated: true)
                    break
            
            case 2:
                
                switch indexPath.row {
                    case 0:
                        UIApplication.shared.open(URL(string: "itms://itunes.apple.com/us/app/cbs-sports/id307184892?mt=8")!, options: [:], completionHandler: nil)
                        break
                        
                    case 1:
                        UIApplication.shared.open(URL(string:  "itms://itunes.apple.com/us/app/cbs-sports-franchise-baseball/id861435884?mt=8")!, options: [:], completionHandler: nil)
                        break
                        
                    case 2:
                        UIApplication.shared.open(URL(string: "itms://itunes.apple.com/us/app/cbs-sports-franchise-football-manager-2016/id1059050333?mt=8")!, options: [:], completionHandler: nil)
                        break
                        
                    default:
                        break
                }
                break
                
                default:
                    break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = UIColor(white: 1.0, alpha:0.5)
        header.textLabel?.font = UIFont(name: "Avenir-Medium", size: 10)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = NSTextAlignment.left
        
        switch section {
            
            case 0:
                header.textLabel?.text = "MORE FANTASY SPORTS"
                break

            case 1:
                header.textLabel?.text = "ADVANCED TOOLS - FANTASY PROS"
                break
            
            case 2:
                header.textLabel?.text = "MORE APPS AND GAMES"
                break
            
            default:
                break
        }
        
        

    }
}


