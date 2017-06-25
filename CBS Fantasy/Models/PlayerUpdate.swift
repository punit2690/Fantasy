//
//  PlayerUpdate.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

struct PlayerUpdate {
    
    let timeStamp: Date
    let players: [Player]
    let author: Author
    let player: Player
    let id: String
    let title: String
    let news: String
    
    init?(from updateDict: [String : Any]) {
        
        guard let id = updateDict["id"] as? String,
            let news = updateDict["news"] as? String,
            let timestampString = updateDict["timestamp"] as? String,
            let authorDict = updateDict["author"] as? [String : Any],
            let author = Author(from: authorDict),
            let playerDict = updateDict["player"] as? [String : Any],
            let player = Player(from: playerDict),
            let title = updateDict["title"] as? String,
            let timestamp = Double(timestampString),
            let playerDicts = updateDict["players"] as? [[String : Any]] else { return nil }
        
        self.timeStamp = Date(timeIntervalSince1970: timestamp)
        self.id = id
        self.player = player
        self.author = author
        self.title = title
        self.news = news
        
        var players = [Player]()
        for playerDict in playerDicts {
            if let player = Player(from: playerDict) {
                players.append(player)
            }
        }
        self.players = players
    }
}
