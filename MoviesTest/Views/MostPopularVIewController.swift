//
//  ViewController.swift
//  MoviesTest
//
//  Created by Camilo López on 5/14/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireImage
import RealmSwift

class MostPopularViewController: BaseViewControlller {
    
    let presenter = MostPopularPresenter(locator: UseCaseLocator.defaultLocator)
    var data: [VideoDetailsModel]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(try! Realm().configuration)
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        showLoader()
        presenter.getMostPopular { [weak self] result in
            guard self != nil else { return }
            self?.hideLoader()
            switch result {
            case .success(let popularMovies):
                self?.data = popularMovies.results
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MostPopularViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.title.text = data?[indexPath.row].title
        
        if let backdropPath = data?[indexPath.row].posterPath {
            let imageURlFromApi = "https://image.tmdb.org/t/p/w185\(backdropPath)"
            cell.coverImage.setImageAndCacheIt(withURL: imageURlFromApi)
        } else {
           cell.coverImage.image = UIImage(named: "placeholder")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetails") as! MovieDetailsViewController
        vc.data = data?[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
}

