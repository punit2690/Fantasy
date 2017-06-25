//
//  FrontsViewModel.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation
import UIKit

class FrontsViewModel {
    
    private var cards: [Card]?
    
    init() {
        initFrontsDataLoad()
    }
    
    func initFrontsDataLoad() {
        
        DispatchQueue.global(qos: .default).async {
            let dataTask = URLSession.shared.dataTask(with: URL(string: frontsURL)!, completionHandler: { (responseObject, response, error) in
                if let recievedData = responseObject {
                    if let json = try! JSONSerialization.jsonObject(with: recievedData, options: .allowFragments) as? [String : Any] {
                        if let body = json["body"] as? [String : Any] {
                            if let app_home = body["app_home"] as? [String : Any] {
                                if let cards = app_home["cards"] as? [[String : Any]] {
                                    var cardArray = [Card]()
                                    for card in cards {
                                        if let card = Card(from: card) {
                                            cardArray.append(card)
                                        }
                                    }
                                    self.cards = cardArray
                                }
                            }
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    func cellForCard(at index: Int, for tableView: UITableView) -> UITableViewCell {
        
        guard cards != nil && index < cards!.count else { return UITableViewCell() }
        
        switch cards![index].cardType {
            case .Headline:
                let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell")!
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    func numberOfRows() -> Int {
        return cards?.count ?? 0
    }
}
