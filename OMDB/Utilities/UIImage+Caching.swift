//
//  UIImage+Caching.swift
//  OMDB
//
//  Created by Pankaj Gaikar on 21/01/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCache (_ urlString : String) {
        self.image = UIImage.init(named: "movie-placeholder")
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if data != nil {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as AnyObject)
                    DispatchQueue.main.async(execute: {
                        self.image = image
                    })
                }
            }
        }.resume()
    }
}
