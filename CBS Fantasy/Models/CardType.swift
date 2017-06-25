//
//  CardDataContainerModel.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

enum CardType: String {
    case Headline = "headlines"
    case RosterTrend = "roster_trends"
    case PlayerVideos = "player_news_videos"
    case Video = "vod"
    case PlayerUpdates = "player_updates"
    case Ad = "banner_ad"
    case Unknown = "unknown"
}

struct Card {
    
    private let type: String
    var data: Any
    var cardType: CardType {
        return CardType(rawValue: type) ?? CardType.Unknown
    }
    
    init?(from cardDict: [String : Any]) {
        
        guard let cardData = cardDict["data"],
            let type = cardDict["type"] as? String  else { return nil }
        self.type = type
        self.data = []
        
        switch type {
            
            case CardType.Headline.rawValue:
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
            
            case CardType.RosterTrend.rawValue:
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
            
            case CardType.PlayerVideos.rawValue:
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
            
            case CardType.Video.rawValue:
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
            
            case CardType.Ad.rawValue:
                self.data = []
                break
            
            case CardType.PlayerUpdates.rawValue:
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

