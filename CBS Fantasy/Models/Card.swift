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
    
    let sport: SPORT
    private let type: String
    var data = [Any]()
    var cardType: CardType {
        return CardType(rawValue: type) ?? CardType.Unknown
    }
    var cardCount: Int {
        
        switch cardType {
            
        case CardType.Headline, CardType.PlayerVideos, CardType.Video:
            return data.count
            
        case CardType.Ad, CardType.RosterTrend, CardType.PlayerUpdates:
            return 1
            
        default:
            return 0
        }
    }
    var source: String {
        return "CBS Fantasy \(sport.rawValue.capitalized)"
    }
    
    var title: String? {
        
        switch cardType {
            
            case CardType.Headline:
                return "Fantasy Advice"
            case CardType.PlayerVideos:
                return "Player News Videos"
            case CardType.Video:
                switch sport {
                    case .Basketball:
                        return "Fantasy Basketball Today Videos"
                    case .Baseball:
                        return "Fantasy Baseball Today Videos"
                    case .Football:
                        return "Fantasy Football Today Videos"
                    case .Hockey:
                        return "Fantasy Hockey Today Videos"
                }
            case CardType.RosterTrend:
                return "Roster Trends"
            case CardType.PlayerUpdates:
                return "Player News"
                
            default:
            return nil
        }
    }
    
    var allButtonTitle: String? {
        
        switch cardType {
            
            case CardType.Headline:
                return "All Advice >"
            case CardType.Video:
                return "All Videos >"
            case CardType.RosterTrend:
                return "All Trends >"
            case CardType.PlayerUpdates:
                return "All News >"
                
            default:
                return ""
        }
    }
    
    init?(from cardDict: [String : Any], for sport: SPORT) {
        
        guard let type = cardDict["type"] as? String  else { return nil }
        self.type = type
        let cardData = cardDict["data"]
        self.data = []
        self.sport = sport

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
                    return nil
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
                    guard rosterTrends.count > 0 else { return nil }
                    self.data = rosterTrends
                } else {
                    return nil
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
                        return nil
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
                        return nil
                    }
                }
                break
            
            case CardType.Ad.rawValue:
                return
            
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
                    return nil
                }
                break
            
            default:
                break
        }
        
        if data.count == 0 && cardType != .Ad {
            return nil
        }
    }
}

