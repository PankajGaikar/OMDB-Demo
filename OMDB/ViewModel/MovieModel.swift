//
//  MovieModel.swift
//  OMDB
//
//  Created by Pankaj Gaikar on 21/01/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

protocol MoviesModelDelegate {
    func dataFetchComplete()
    //TODO:- Add failure method and show error on UI.
}

class MovieModel {
    
    var movies = [Movie]()
    //API page counter
    var page = 0
    
    //Total count available on server
    var totalCount = 0
    
    //Data updation protocol instance
    var movieDataModelDelegate: MoviesModelDelegate?
    
    func getMovies() {
        //Initial increase from 0 to 1
        page = page + 1
        
        //If if's not first page and all data is fetched, may be no need of another network call.
        if page > 1 && totalCount <= self.movies.count {
            print("All Data fetched.")
        }
        
        APIService().getMovies(page: page, completion: { result in
            switch result {
            case .success(let response):
                self.movies.append(contentsOf: response.movies)
                self.totalCount = Int(response.totalResults) ?? 0
                self.movieDataModelDelegate?.dataFetchComplete()
                break
                
            case .failure( _):
                //TODO:- Show error?
                print("FAILURE")
                break
                
            }
        })
    }
}
