//
//  Config.swift
//  MovieRandom
//
//  Created by Rhett Rogers on 10/21/15.
//  Copyright © 2015 Rhett Rogers. All rights reserved.
//

import UIKit

class Config {
    static var app = Config()
    
    var apiKey: String = ""
    var dict = [String: AnyObject]()
    init() {
        if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist"),
            let temp = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: path)),
            let d = temp as? [String: AnyObject]{
            dict = d
            if let a = dict["APIKey"] as? String {
                apiKey = a
            }
        }
        
    }
}
