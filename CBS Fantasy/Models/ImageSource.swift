//
//  ImageSource.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

struct ImageSource {
    
    let width: UInt
    let contentId: String
    let source: String
    let height: UInt
    //let captionOnly: Bool
    
    init?(from imageDict: [String : Any]) {
        guard let widthString = imageDict["width"] as? String,
            let heightString = imageDict["height"] as? String,
            let contentId = imageDict["content_id"] as? String,
            let source = imageDict["src"] as? String,
            let width = UInt(widthString),
            let height = UInt(heightString) else { return nil }
        
        self.width = width
        self.height = height
        self.source = source
        self.contentId = contentId
        //self.captionOnly = captionOnly
    }
}
