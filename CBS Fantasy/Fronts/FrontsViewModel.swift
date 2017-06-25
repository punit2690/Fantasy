//
//  FrontsViewModel.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

class FrontsViewModel {
    
    var cardTypes: [CardType]?
    
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
                                    var cardTypes = [CardType]()
                                    for card in cards {
                                        if let cardType = CardType(from: card) {
                                            cardTypes.append(cardType)
                                        }
                                    }
                                    self.cardTypes = cardTypes
                                }
                            }
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
}
