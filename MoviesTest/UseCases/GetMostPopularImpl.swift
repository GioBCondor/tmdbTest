//
//  GetMostPopular.swift
//  MoviesTest
//
//  Created by Camilo López on 5/14/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

protocol GetMostPopular {
    func get(_ completion:@escaping (GetMostPopularResult) -> Void)
}

enum GetMostPopularResult {
    enum Error {
        case unknown
        case notInternetConnection
    }
    case success(popularMovies: MostPopularServiceModel)
    case failure(error: Error)
}


class GetMostPopularImpl: UseCaseImpl, GetMostPopular {
    func get(_ completion:@escaping (GetMostPopularResult) -> Void) {
        service.getMostPopular() {  (result) in
            switch result {
            case .success(let popularMovies):
                self.repository.save(mostPopular: popularMovies)
                completion(.success(popularMovies: popularMovies))
            case .failure(let error):
                if error == .notInternetConnection {
                    self.getFromCache(completion: completion)
                } else {
                    completion(.failure(error: error))
                }
                
            }
        }
    }
    
    func getFromCache(completion:@escaping (GetMostPopularResult) -> Void) {
        repository.getMostPopular() { result in
           completion(result)
        }
    }
}
