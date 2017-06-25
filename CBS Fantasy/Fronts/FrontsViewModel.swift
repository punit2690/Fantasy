//
//  FrontsViewModel.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation
import UIKit

protocol FrontsViewModelDelegate: class {
    func reloadData()
}

class FrontsViewModel {
    
    fileprivate var cards: [Card]? {
        didSet {
            self.delegate.reloadData()
        }
    }
    private var delegate: FrontsViewModelDelegate
    
    init(delegate: FrontsViewModelDelegate) {
        self.delegate = delegate
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
        let card = cards![index]
        switch card.cardType {
            case .Headline, .PlayerVideos, .Video:
                let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
                cell.setup(for: self, index: index, title: card.title!.capitalized, allButtonTitle: card.allButtonTitle?.uppercased())
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    func numberOfRows() -> Int {
        return cards?.count ?? 0
    }
}

extension FrontsViewModel: CarouselTableViewCellDelegate {
    
    func numberOfCells(for rowIndex: Int) -> Int {
        let card = cards![rowIndex]
        return card.cardCount
    }
    
    func cellForItem(at index: Int, for collectionView: UICollectionView, on rowIndex: Int) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCollectionViewCell", for: IndexPath(row: index, section: 0))
        return cell
    }
    
    func didSelectItem(at index: Int, on rowIndex: Int) {
        
    }
}
