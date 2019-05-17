//
//  MovieDetails.swift
//  MoviesTest
//
//  Created by Camilo López on 5/16/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewControlller {
    
    @IBOutlet weak var moviePicture: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    var data: VideoDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataToUI()
    }
    
    func loadDataToUI() {
        if let posterPath = data?.posterPath {
            let imageURlFromApi = "https://image.tmdb.org/t/p/w185\(posterPath)"
            moviePicture.setImageAndCacheIt(withURL: imageURlFromApi)
        }
        
        movieTitle.text = data?.title
        movieDescription.text = data?.overview
    }
    
    @IBAction func tapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
