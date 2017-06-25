//
//  CardDataContainerModel.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

struct CardType {
    
    let type: String
    var data: Any
    
    init?(from cardDict: [String : Any]) {
        
        guard let cardData = cardDict["data"],
            let type = cardDict["type"] as? String  else { return nil }
        self.type = type
        self.data = []
        
        switch type {
            
            case "headlines":
                var headlines = [HeadlineCard]()
                if let headlineJSONArray = cardData as? [[String : Any]] {
                    for headlineJSON in headlineJSONArray {
                        if let headline = HeadlineCard(from: headlineJSON) {
                            headlines.append(headline)
                        }
                    }
                    self.data = headlines
                } else {
                    self.data = []
                }
                break
            
            case "roster_trends":
                var rosterTrends = [RosterTrend]()
                if let rosterTrendsJSONArray = cardData as? [[String : Any]] {
                    for rosterDict in rosterTrendsJSONArray {
                        if let rosterTrend = RosterTrend(with: rosterDict) {
                            rosterTrends.append(rosterTrend)
                        }
                    }
                    self.data = rosterTrends
                } else {
                    self.data = []
                }
                break
            
            case "player_news_videos":
                var videos = [PlayerNewsVideo]()
                if let playerNewsVideoJSON = cardData as? [String : Any] {
                    if let playerNewsVideoJSONs = playerNewsVideoJSON["videos"] as? [[String : Any]] {
                        for video in playerNewsVideoJSONs {
                            if let video = PlayerNewsVideo(from: video) {
                                videos.append(video)
                            }
                        }
                        self.data = videos
                    } else {
                        self.data = []
                    }
                }
                break
            
            case "vod":
                var videos = [Video]()
                if let videoJSON = cardData as? [String : Any] {
                    if let videoJSONs = videoJSON["videos"] as? [[String : Any]] {
                        for video in videoJSONs {
                            if let video = Video(from: video) {
                                videos.append(video)
                            }
                        }
                        self.data = videos
                    } else {
                        self.data = []
                    }
                }
                break
            
            case "banner_ad":
                self.data = []
                break
            
            case "player_updates":
                var updates = [PlayerUpdate]()
                if let playerUpdatesJSONArray = cardData as? [[String : Any]] {
                    for update in playerUpdatesJSONArray {
                        if let playerUpdate = PlayerUpdate(from: update) {
                            updates.append(playerUpdate)
                        }
                    }
                    self.data = updates
                } else {
                    self.data = []
                }
                break
            
            default:
                break
        }
    }
}

