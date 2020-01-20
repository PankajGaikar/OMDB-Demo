//
//  Search.swift
//  OMDB
//
//  Created by Pankaj Gaikar on 21/01/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

class Search: Codable {
    let movies: [Movie]
    let totalResults: String
    
    init(movies: [Movie], totalResults: String) {
        self.movies = movies
        self.totalResults = totalResults
    }

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
    }
}
