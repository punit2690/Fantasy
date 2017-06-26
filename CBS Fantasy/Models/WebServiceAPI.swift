//
//  WebServiceAPI.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

enum SPORT: String {
    case Baseball = "baseball"
    case Basketball = "basketball"
    case Football = "football"
    case Hockey = "hockey"
}

func frontURL(for sport: SPORT) -> String {
    return "http://api.cbssports.com/fantasy/mobile/league/app-home?SPORT=\(sport.rawValue)&response_format=JSON&version=3.1&access_token=&context=&league_id=dummy-league&display_size=standard&no_ads=0"
}
