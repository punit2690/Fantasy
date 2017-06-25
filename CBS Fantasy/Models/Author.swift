//
//  AuthorStruct.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

struct Author {
    
    let byline: String
    let id: String
    let lastName: String
    let firstName: String
    
    init?(from authorDict: [String : Any]) {
        
        guard let byline = authorDict["byline"] as? String,
              let id = authorDict["id"] as? String,
              let lastName = authorDict["last_name"] as? String,
              let firstName = authorDict["first_name"] as? String else { return nil }
        
        self.byline = byline
        self.id = id
        self.lastName = lastName
        self.firstName = firstName
    }
}
