//
//  API.swift
//  MovieRandom
//
//  Created by Rhett Rogers on 10/21/15.
//  Copyright © 2015 Rhett Rogers. All rights reserved.
//

import UIKit

enum APIError: ErrorType {
    case ServerError,
        NoInternet,
        TranslationFailed
}

enum ModelType {
    case Company,
    Collection,
    Keyword,
    List,
    Movie,
    Multi,
    Person,
    TV
}


class API {
    static let apiBase = "http://api.themoviedb.org/3"

    class func search(query: String, type: ModelType, callback: ((APIError?, AnyObject?) -> Void)) {
        var urlString = "\(apiBase)/search"
        switch type {
        case .Company: urlString = "\(urlString)/company"
        case .Collection: urlString = "\(urlString)/collection"
        case .Keyword: urlString = "\(urlString)/keyword"
        case .List: urlString = "\(urlString)/list"
        case .Movie: urlString = "\(urlString)/movie"
        case .Multi: urlString = "\(urlString)/multi"
        case .Person: urlString = "\(urlString)/person"
        case .TV: urlString = "\(urlString)/tv"
        }
        
        urlString = "\(urlString)?query=\(query)&api_key=\(Config.app.apiKey)"
        if let url = NSURL(string: urlString) {
            request(url) { (error, tuple) -> Void in
                if let tuple = tuple {
                    if tuple.0.count > 0 {
                        callback(nil, tuple.0)
                    }
                    
                    if tuple.1.count > 0 {
                        callback(nil, tuple.1)
                    }
                }
                callback(error, nil)
            }
        }
        
    }
    
    
    class func request(url: NSURL, callback: ((APIError?, ([AnyObject], [String: AnyObject])?) -> Void)) {
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let data = data {
                do {
                    try callback(nil, JSONParser.jsonFromData(data))
                } catch {
                    callback(.TranslationFailed, nil)
                }
            } else {
                callback(.ServerError, nil)
            }
        }
        
        task.resume()
    }
}
