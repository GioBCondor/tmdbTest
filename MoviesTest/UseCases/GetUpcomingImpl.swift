//
//  GetUpcomingImpl.swift
//  MoviesTest
//
//  Created by Camilo López on 5/16/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

protocol GetUpcoming {
    func get(_ completion:@escaping (GetUpcomingResult) -> Void)
}

enum GetUpcomingResult {
    enum Error {
        case unknown
        case notInternetConnection
    }
    case success(upcoming: UpcomingModel)
    case failure(error: Error)
}


class GetUpcomingImpl: UseCaseImpl, GetUpcoming {
    func get(_ completion:@escaping (GetUpcomingResult) -> Void) {
        service.getUpcoming() {  (result) in
            switch result {
            case .success(let Upcoming):
                self.repository.save(upcoming: Upcoming)
                completion(.success(upcoming: Upcoming))
            case .failure(let error):
                if error == .notInternetConnection {
                    self.getFromCache(completion: completion)
                } else {
                    completion(.failure(error: error))
                }
                
            }
        }
    }
    
    func getFromCache(completion:@escaping (GetUpcomingResult) -> Void) {
        repository.getUpcoming() { result in
            completion(result)
        }
    }
}
