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
    func showHUD()
    func hideHUD()
}

class FrontsViewModel {
    
    fileprivate var cards: [Card]? {
        didSet {
            self.delegate.reloadData()
        }
    }
    private var delegate: FrontsViewModelDelegate
    var selectedSport: SPORT {
        didSet {
            beginFrontsDataLoad()
        }
    }
    
    init(delegate: FrontsViewModelDelegate, selectedSport: SPORT) {
        self.delegate = delegate
        self.selectedSport = selectedSport
        beginFrontsDataLoad()
    }
    
    func beginFrontsDataLoad() {
        
        self.delegate.showHUD()
        DispatchQueue.global(qos: .default).async { [unowned self] in
            let dataTask = URLSession.shared.dataTask(with: URL(string: frontURL(for: self.selectedSport))!, completionHandler: { (responseObject, response, error) in
                if let recievedData = responseObject {
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: recievedData, options: .allowFragments) as? [String : Any] {
                            if let body = json["body"] as? [String : Any] {
                                if let app_home = body["app_home"] as? [String : Any] {
                                    
                                    if let cards = app_home["cards"] as? [[String : Any]] {
                                        var cardArray = [Card]()
                                        for card in cards {
                                            if let card = Card(from: card, for: self.selectedSport) {
                                                cardArray.append(card)
                                            }
                                        }
                                        self.cards = cardArray
                                    }
                                }
                            }
                        }
                    } catch {
                        print("ERROR: Error parsing response data")
                    }
                }
                self.delegate.hideHUD()
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
            
            case .Ad:
                let cell = tableView.dequeueReusableCell(withIdentifier: "adTableViewCell")!
                return cell
            
            case .RosterTrend:
                let cell = tableView.dequeueReusableCell(withIdentifier: "rosterTrendsCell") as! RosterTableViewCell
                cell.setup(for: self, index: index, title: card.title!, allButtonTitle: card.allButtonTitle?.uppercased())
                return cell
            
            case .PlayerUpdates:
                let cell = tableView.dequeueReusableCell(withIdentifier: "playerUpdatesTableViewCell") as! PlayerUpdatesTableViewCell
                cell.setup(for: self, index: index, title: card.title!, allButtonTitle: card.allButtonTitle?.uppercased())
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
    
    func numberOfCellsForCarouselCell(for rowIndex: Int) -> Int {
        let card = cards![rowIndex]
        return card.cardCount
    }
    
    func cellForItemForCarouselCell(at index: Int, for collectionView: UICollectionView, on rowIndex: Int) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCollectionViewCell", for: IndexPath(row: index, section: 0)) as! CarouselCollectionViewCell
        let cellArray = cards![rowIndex].data as! [CarouselTableViewCellProtocol]
        let cellData = cellArray[index]
        let source = cellData.source.characters.count > 0 ? cellData.source : cards![rowIndex].source
        cell.setup(for: self, title: cellData.title, timestamp: cellData.timestamp, source: source, imageURL: cellData.imageURL)
        return cell
    }
    
    func didSelectItemForCarouselCell(at index: Int, on rowIndex: Int) {
        
    }
}

extension FrontsViewModel: RosterTableViewCellDelegate {
    
    func numberOfSectionsInRosterCell(for index: Int) -> Int {
        return cards![index].data.count
    }
    
    func numberOfRowsInRosterCell(in section: Int, for rowIndex: Int) -> Int {
        return (cards![rowIndex].data as! [RosterTrend])[section].players.count
    }
    
    func cellForRowInRosterCell(at indexpath: IndexPath, for rowIndex: Int, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerTableViewCell") as! PlayerTableViewCell
        let rosterTrends = cards![rowIndex].data as! [RosterTrend]
        let rosterTrend = rosterTrends[indexpath.section]
        cell.setup(with: rosterTrend.players[indexpath.row])
        return cell
    }
    
    func viewForHeaderInRosterCell(in section: Int, for rowIndex: Int) -> UIView {
        let headerView = Bundle.main.loadNibNamed("RosterTableSectionView", owner: nil, options: nil)?.first as! RosterSectionHeaderView
        let rosterTrends = cards![rowIndex].data as! [RosterTrend]
        let rosterTrend = rosterTrends[section]
        headerView.labelView.text = rosterTrend.type
        return headerView
    }
}

extension FrontsViewModel: PlayerUpdatesTableViewCellDelegate {
    
    func numberOfRowsInPlayerUpdates(for rowIndex: Int) -> Int {
        return (cards![rowIndex].data as! [PlayerUpdate]).count
    }
    
    func cellForRowInPlayerUpdates(at indexpath: Int, for rowIndex: Int, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerTableViewCell") as! PlayerTableViewCell
        let playerUpdates = cards![rowIndex].data as! [PlayerUpdate]
        cell.setup(with: playerUpdates[indexpath])
        return cell
    }
}
