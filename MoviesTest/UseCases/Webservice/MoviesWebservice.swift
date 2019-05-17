//
//  MoviesWebservice.swift
//  MoviesTest
//
//  Created by Camilo López on 5/15/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

protocol MoviesWebservice {
    func getMostPopular(_ completion:@escaping (GetMostPopularResult) -> Void)
    func getUpcoming(_ completion:@escaping (GetUpcomingResult) -> Void)
    func getTopRated(_ completion:@escaping (GetTopRatedResult) -> Void)
    func getSearch(by keyword: String, _ completion:@escaping (GetSearchResult) -> Void)
}
class WebMoviesWebservice: MoviesWebservice {
    let baseService = BaseService()
    func getMostPopular(_ completion:@escaping (GetMostPopularResult) -> Void) {
        let endPoint = Constants.baseURL + Constants.mostPopularEndPoint
        baseService.callEndpoint(endPoint: endPoint) { result in
            switch result {
            case .success(let response, _):
                do {
                    let jsonDecoder = JSONDecoder()
                    let popularMovies = try jsonDecoder.decode(MostPopularServiceModel.self, from: response)
                    completion(.success(popularMovies: popularMovies))
                } catch {
                    completion(.failure(error: .unknown))
                }
            case .notConnectedToInternet:
                completion(.failure(error: .notInternetConnection))
            case .expiredToken:
                completion(.failure(error: .unknown))
            case .reauthenticationRequired:
                completion(.failure(error: .unknown))
            case .failure:
                completion(.failure(error: .unknown))
            }
        }
    }
    
    func getUpcoming(_ completion:@escaping (GetUpcomingResult) -> Void) {
        let endPoint = Constants.baseURL + Constants.upcomingEndPoint
        baseService.callEndpoint(endPoint: endPoint) { result in
            switch result {
            case .success(let response, _):
                do {
                    let jsonDecoder = JSONDecoder()
                    let upcoming = try jsonDecoder.decode(UpcomingModel.self, from: response)
                    completion(.success(upcoming: upcoming))
                } catch {
                    completion(.failure(error: .unknown))
                }
            case .notConnectedToInternet:
                completion(.failure(error: .notInternetConnection))
            case .expiredToken:
                completion(.failure(error: .unknown))
            case .reauthenticationRequired:
                completion(.failure(error: .unknown))
            case .failure:
                completion(.failure(error: .unknown))
            }
        }
    }
    
    func getTopRated(_ completion:@escaping (GetTopRatedResult) -> Void) {
        let endPoint = Constants.baseURL + Constants.topRatedEndPoint
        baseService.callEndpoint(endPoint: endPoint) { result in
            switch result {
            case .success(let response, _):
                do {
                    let jsonDecoder = JSONDecoder()
                    let topRated = try jsonDecoder.decode(TopRatedServiceModel.self, from: response)
                    completion(.success(topRated: topRated))
                } catch {
                    debugPrint("error \(error)")
                    completion(.failure(error: .unknown))
                }
            case .notConnectedToInternet:
                completion(.failure(error: .notInternetConnection))
            case .expiredToken:
                completion(.failure(error: .unknown))
            case .reauthenticationRequired:
                completion(.failure(error: .unknown))
            case .failure:
                completion(.failure(error: .unknown))
            }
        }
    }
    
    func getSearch(by keyword: String, _ completion:@escaping (GetSearchResult) -> Void) {
        let endPoint = Constants.baseURL + Constants.searchEndPoint + keyword
        baseService.callEndpoint(endPoint: endPoint) { result in
            switch result {
            case .success(let response, _):
                do {
                    let jsonDecoder = JSONDecoder()
                    let search = try jsonDecoder.decode(SearchServiceModel.self, from: response)
                    completion(.success(search: search))
                } catch {
                    debugPrint("error \(error)")
                    completion(.failure(error: .unknown))
                }
            case .notConnectedToInternet:
                completion(.failure(error: .notInternetConnection))
            case .expiredToken:
                completion(.failure(error: .unknown))
            case .reauthenticationRequired:
                completion(.failure(error: .unknown))
            case .failure:
                completion(.failure(error: .unknown))
            }
        }
    }
}
