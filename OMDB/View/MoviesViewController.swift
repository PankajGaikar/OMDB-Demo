//
//  ViewController.swift
//  OMDB
//
//  Created by Pankaj Gaikar on 21/01/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    //MARK:- View model instance
    let movieModel = MovieModel()
    
    //MARK:- View element
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "OMDB"
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Create default flowlayout for 2*2 grid
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2, height: (UIScreen.main.bounds.size.width/2 * 1.5))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        //Start data fetch from view model
        movieModel.getMovies()
        //Confirm to data update protocol.
        movieModel.movieDataModelDelegate = self
    }
}

//MARK:- CollectionView Delegates
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.titleLabel.text = movieModel.getTitle(forIndex: indexPath.row)
        cell.yearLabel.text = movieModel.getYear(forIndex: indexPath.row)
        cell.typeLabel.text = movieModel.getType(forIndex: indexPath.row)
        cell.posterImageView.loadImageUsingCache(movieModel.getPoster(forIndex: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieModel.movies.count - 1 {
            print("Reached end of data. Fetch more.")
            movieModel.getMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailsViewController = self.storyboard?.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetailsViewController.movie = movieModel.movies[indexPath.row]
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}

//MARK:- CollectionView FlowLayout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = 2
        let width = (collectionView.frame.size.width - CGFloat(padding) * 2) / CGFloat(2)
        let height = UIScreen.main.bounds.size.width/2 * 1.5
        return CGSize(width: width, height: height)
    }
}

//MARK:- View Model Protocol
extension MoviesViewController: MoviesModelDelegate {
    func dataFetchComplete() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
