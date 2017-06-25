//
//  HeadlineCard.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

struct HeadlineCard {
    
    let id: String
    let imageSources: [ImageSource]
    let synopsis: String
    let timeStamp: Date
    let author: String
    let title: String
    
    init?(from headlineDict: [String : Any]) {
        
        guard let id = headlineDict["id"] as? String,
            let synopsis = headlineDict["synopsis"] as? String,
            let timestampString = headlineDict["timestamp"] as? String,
            let author = headlineDict["author"] as? String,
            let title = headlineDict["title"] as? String,
            let timestamp = Double(timestampString),
            let imageSources = headlineDict["photos"] as? [[String : Any]] else { return nil }
        
        self.timeStamp = Date(timeIntervalSince1970: timestamp)
        self.id = id
        self.synopsis = synopsis
        self.author = author
        self.title = title
        
        var sources = [ImageSource]()
        for imageDict in imageSources {
            if let imageSource = ImageSource(from: imageDict) {
                sources.append(imageSource)
            }
        }
        self.imageSources = sources
    }
}
