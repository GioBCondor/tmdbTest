//
//  GetTopRatedImpl.swift
//  MoviesTest
//
//  Created by Camilo López on 5/16/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

protocol GetTopRated {
    func get(_ completion:@escaping (GetTopRatedResult) -> Void)
}

enum GetTopRatedResult {
    enum Error {
        case unknown
        case notInternetConnection
    }
    case success(topRated: TopRatedServiceModel)
    case failure(error: Error)
}

class GetTopRatedImpl: UseCaseImpl, GetTopRated {
    
    func get(_ completion:@escaping (GetTopRatedResult) -> Void) {
        service.getTopRated {  (result) in
            switch result {
            case .success(let topRated):
                self.repository.save(topRated: topRated)
                completion(.success(topRated: topRated))
            case .failure(let error):
                if error == .notInternetConnection {
                    self.getFromCache(completion: completion)
                } else {
                    completion(.failure(error: error))
                }
                
            }
        }
    }
    
    func getFromCache(completion:@escaping (GetTopRatedResult) -> Void) {
        repository.getTopRated { result in
            completion(result)
        }
    }
}
