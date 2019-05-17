//
//  GetSearchImpl.swift
//  MoviesTest
//
//  Created by Camilo López on 5/16/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

protocol GetSearch {
    func get(by keyword:String, _ completion:@escaping (GetSearchResult) -> Void)
}

enum GetSearchResult {
    enum Error {
        case unknown
        case notInternetConnection
    }
    case success(search: SearchServiceModel)
    case failure(error: Error)
}

class GetSearchImpl: UseCaseImpl, GetSearch {
    
    func get(by keyword: String, _ completion:@escaping (GetSearchResult) -> Void) {
        service.getSearch(by: keyword) {  (result) in
            switch result {
            case .success(let search):
                completion(.success(search: search))
            case .failure(let error):
                if error == .notInternetConnection {
                    self.getFromCache(searchText: keyword,completion: completion)
                } else {
                    completion(.failure(error: error))
                }
                
            }
        }
    }
    
    func getFromCache(searchText: String, completion:@escaping (GetSearchResult) -> Void) {
        repository.getSearch(searchText: searchText) { result in
            completion(result)
        }
    }
}
