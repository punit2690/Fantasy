//
//  Player.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

struct Player {
    
    let id: String
    let firstName: String
    let lastName: String
    let fullName: String
    let profileUrl: String
    let position: String
    let diff: Int?
    let team: String
    let photoUrl: String
    
    init?(from playerDict: [String : Any]) {
        guard let id = playerDict["id"] as? String,
            let firstName = playerDict["firstname"] as? String,
            let lastName = playerDict["lastname"] as? String,
            let fullName = playerDict["fullname"] as? String,
            let profileUrl = playerDict["profile_url"] as? String,
            let position = playerDict["position"] as? String,
            let team = playerDict["pro_team"] as? String,
            let photoUrl = playerDict["photo"] as? String else { return nil }

        self.diff = playerDict["diff"] as? Int
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.profileUrl = profileUrl
        self.position = position
        self.team = team
        self.photoUrl = photoUrl
    }
}
