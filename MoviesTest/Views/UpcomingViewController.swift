//
//  UpcomingViewController.swift
//  MoviesTest
//
//  Created by Camilo López on 5/16/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation
import UIKit

class UpcomingViewController: BaseViewControlller {
    
    let presenter = UpcomingPresenter(locator: UseCaseLocator.defaultLocator)
    var data: [VideoDetailsModel]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        showLoader()
        presenter.getUpcoming { [weak self] result in
            guard self != nil else { return }
            self?.hideLoader()
            switch result {
            case .success(let upcomingMovies):
                self?.data = upcomingMovies.results
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDataSource, UITableViewDelegate {
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
