//
//  UseCaseLocator.swift
//  MoviesTest
//
//  Created by Camilo López on 5/15/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

protocol UseCaseLocatorProtocol {
    func getUseCase<T>(ofType type: T.Type) -> T?
}

class UseCaseImpl {
    let repository: MoviesRepository
    let service: MoviesWebservice
    
    required init(repository: MoviesRepository, service: MoviesWebservice) {
        self.repository = repository
        self.service = service
    }
}

class UseCaseLocator: UseCaseLocatorProtocol {
    static let defaultLocator = UseCaseLocator(repository: RealmMoviesRepository(),
                                               service: WebMoviesWebservice())
    
    fileprivate let repository: MoviesRepository
    fileprivate let service: MoviesWebservice
    
    init(repository: MoviesRepository, service: MoviesWebservice) {
        self.repository = repository
        self.service = service
    }
    
    func getUseCase<T>(ofType type: T.Type) -> T? {
        switch String(describing: type) {
        case String(describing: GetMostPopular.self):
            return buildUseCase(type: GetMostPopularImpl.self)
        case String(describing: GetUpcoming.self):
            return buildUseCase(type: GetUpcomingImpl.self)
        case String(describing: GetTopRated.self):
            return buildUseCase(type: GetTopRatedImpl.self)
        case String(describing: GetSearch.self):
            return buildUseCase(type: GetSearchImpl.self)
        default:
            return nil
        }
    }
}

private extension UseCaseLocator {
    func buildUseCase<U: UseCaseImpl, R>(type: U.Type) -> R? {
        return U(repository: repository, service: service) as? R
    }
}
