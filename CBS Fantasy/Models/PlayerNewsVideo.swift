//
//  PlayerNewsVideo.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

typealias PlayerNewsVideo = Video

struct Video {
    
    let mediumThumbUrl: String
    let title: String
    let startTime: Date
    let description: String
    
    init?(from playerNewsVideoDict: [String : Any]) {
        
        guard let medUrl = playerNewsVideoDict["medium_thumbnail"] as? String,
              let title  = playerNewsVideoDict["title"] as? String,
              let timeString  = playerNewsVideoDict["start_time"] as? String,
              let description  = playerNewsVideoDict["description"] as? String,
              let timeInterval = Double(timeString) else { return nil }

        self.startTime = Date(timeIntervalSince1970: timeInterval)
        self.mediumThumbUrl = medUrl
        self.title = title
        self.description = description
    }
}
