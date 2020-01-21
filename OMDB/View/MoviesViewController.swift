//
//  ViewController.swift
//  OMDB
//
//  Created by Pankaj Gaikar on 21/01/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    let movieModel = MovieModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OMDB"
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2, height: (UIScreen.main.bounds.size.width/2 * 1.5))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        movieModel.getMovies()
        movieModel.movieDataModelDelegate = self
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.titleLabel.text = movieModel.movies[indexPath.row].title
        cell.yearLabel.text = movieModel.movies[indexPath.row].year
        cell.typeLabel.text = movieModel.movies[indexPath.row].type
        cell.posterImageView.loadImageUsingCache(movieModel.movies[indexPath.row].poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieModel.movies.count - 1 {
            print("Reached end of data. Fetch more.")
            movieModel.getMovies()
        }
    }
}

extension MoviesViewController: MoviesModelProtocol {
    func dataFetchComplete() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
//extension MoviesViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cell = collectionView.cellForItem(at: indexPath)
//        return CGSize(width: UIScreen.main.bounds.size.width/2, height: cell?.frame.size.height ?? UIScreen.main.bounds.size.width/2);
//    }
//}
