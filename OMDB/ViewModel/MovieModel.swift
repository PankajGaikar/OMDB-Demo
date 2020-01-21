//
//  MovieModel.swift
//  OMDB
//
//  Created by Pankaj Gaikar on 21/01/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

protocol MoviesModelProtocol {
    func dataFetchComplete()
}

class MovieModel {
    
    var movies = [Movie]()
    var page = 0
    var totalCount = 0
    var movieDataModelDelegate: MoviesModelProtocol?
    
    func getMovies() {
        page = page + 1
        
        if page > 1 && totalCount <= self.movies.count {
            print("All Data fetched.")
        }
        
        APIService().getMovies(page: page, completion: { result in
            switch result {
            case .success(let response):
                print("SUCCESS")
                self.movies.append(contentsOf: response.movies)
                self.totalCount = Int(response.totalResults) ?? 0
                self.movieDataModelDelegate?.dataFetchComplete()
                break
                
            case .failure( _):
                print("FAILURE")
                break
                
            }
        })
    }
}
