//
//  APIService.swift
//  OMDB
//
//  Created by Pankaj Gaikar on 21/01/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

class APIService {
    func getMovies(page: Int, completion: @escaping(Result<Search, Error>) -> Void) {
        
        //TODO: Add URI in constant.
        let urlString = "http://www.omdbapi.com/?s=Batman&page=" + String(page) + "&apikey=eeefc96f"

        guard let omdbURI = URL(string: urlString) else {
            return
        }

        let dataTask = URLSession.shared.dataTask(with: omdbURI, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                completion(.failure(error!))
                return
            }

            do {
                // Decode the json data.
                let decoder = JSONDecoder()
                let search = try decoder.decode(Search.self, from: data)
                completion(.success(search))
            } catch {
                print(error)
                completion(.failure(error))
            }
        })

        dataTask.resume()
    }
}
