//
//  RosterTrend.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

struct RosterTrend {
    
    let type: String
    let players: [Player]
    
    init?(with rosterTrendDict: [String : Any]) {
        
        guard let type = rosterTrendDict["type"] as? String,
        let data = rosterTrendDict["data"] as? [String : [[String : Any]]],
        let playerData = data["players"] else { return nil }
        
        var players = [Player]()
        for playerDict in playerData {
            if let player = Player(from: playerDict) {
                players.append(player)
            } else {
                return nil
            }
        }
        self.players = players
        self.type  = type
    }
    
}
