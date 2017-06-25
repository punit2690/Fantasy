//
//  PlayerNewsVideo.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

typealias PlayerNewsVideo = Video

struct Video: CarouselTableViewCellProtocol {
    
    let imageURL: String
    let title: String
    let timestamp: Date
    let description: String
    
    var source: String {
        return ""
    }
    
    init?(from playerNewsVideoDict: [String : Any]) {
        
        guard let medUrl = playerNewsVideoDict["medium_thumbnail"] as? String,
              let title  = playerNewsVideoDict["title"] as? String,
              let timeString  = playerNewsVideoDict["start_time"] as? String,
              let description  = playerNewsVideoDict["description"] as? String,
              let timeInterval = Double(timeString) else { return nil }

        self.timestamp = Date(timeIntervalSince1970: timeInterval)
        self.imageURL = medUrl
        self.title = title
        self.description = description
    }
}
