//
//  Movie.swift
//  MovieRandom
//
//  Created by Rhett Rogers on 10/21/15.
//  Copyright © 2015 Rhett Rogers. All rights reserved.
//

import UIKit

class Movie {
    
    init(dict: [String : AnyObject]) {
        
    }
    
    class func searchMovies(query: String, callback: ( (APIError?, [Movie]) -> Void )) {
        API.search(query, type: .Movie) { (error, movie) -> Void in
            if let movieArr = movie as? [AnyObject] {
                var movies = [Movie]()
                for m in movieArr {
                    if let m = m as? [String: AnyObject] {
                        let 🎥 = Movie(dict: m)
                        movies.append(🎥)
                    }
                }
                callback(nil, movies)
            } else if let movieDict = movie as? [String: AnyObject] {
                callback(nil, [Movie(dict: movieDict)])
            }
        }
    }
    
    
}
