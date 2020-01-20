//
//  MovieModel.swift
//  OMDB
//
//  Created by Pankaj Gaikar on 21/01/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

class MovieModel {
    
    var movies: [Movie]?
    
    func getMovies() {
        APIService().getMovies(completion: { result in
            switch result {
                case .success(let response):
                    print("SUCCESS")
                    self.movies = response.movies
                    break
                case .failure( _):
                    print("FAILURE")
                    // Show Error alert
                    DispatchQueue.main.async {

                    }
                    break
            }
        })
    }

}
