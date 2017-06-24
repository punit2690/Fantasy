//
//  FrontsViewModel.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/24/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import Foundation

class FrontsViewModel {
    
    init() {
        initFrontsDataLoad()
    }
    
    func initFrontsDataLoad() {
        let dataTask = URLSession.shared.dataTask(with: URL(string: frontsURL)!, completionHandler: { (responseObject, response, error) in
            print("ResponseObject: \(String(describing: try! JSONSerialization.jsonObject(with: responseObject!, options: .allowFragments)))")
        })
        dataTask.resume()
    }
}
