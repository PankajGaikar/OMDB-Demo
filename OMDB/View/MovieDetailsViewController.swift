//
//  MovieDetailsViewController.swift
//  OMDB
//
//  Created by Pankaj Gaikar on 22/01/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var movie: Movie? = nil
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movie?.title
        self.titleLabel.text = movie?.title
        self.yearLabel.text = movie?.year
        self.posterImageView.loadImageUsingCache(movie?.poster ?? "")
        self.typeLabel.text = movie?.type
    }
}
