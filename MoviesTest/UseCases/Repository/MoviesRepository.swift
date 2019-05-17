//
//  MoviesRepository.swift
//  MoviesTest
//
//  Created by Camilo López on 5/15/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//
import Foundation
import RealmSwift

class RealmMostPopular: Object {
    @objc dynamic var r_page = 0
    @objc dynamic var r_total_results = 0
    @objc dynamic var r_total_pages = 0
    var r_results = List<RealmMovieResults>()
    override static func primaryKey() -> String? {
        return "r_page"
    }
}

class RealmUpcoming: Object {
    @objc dynamic var r_page = 0
    @objc dynamic var r_total_results = 0
    @objc dynamic var r_total_pages = 0
    var r_results = List<RealmMovieResults>()
    override static func primaryKey() -> String? {
        return "r_page"
    }
}

class RealmTopRated: Object {
    @objc dynamic var r_page = 0
    @objc dynamic var r_total_results = 0
    @objc dynamic var r_total_pages = 0
    var r_results = List<RealmMovieResults>()
    override static func primaryKey() -> String? {
        return "r_page"
    }
}

class RealmMovieResults: Object {
    @objc dynamic var r_id = 0
    @objc dynamic var r_posterPath = ""
    @objc dynamic var r_adult = false
    @objc dynamic var r_budget = 0
    @objc dynamic var r_overview = ""
    @objc dynamic var r_releaseDate = ""
    @objc dynamic var r_originalTitle = ""
    @objc dynamic var r_originalLanguage = ""
    @objc dynamic var r_title = ""
    @objc dynamic var r_backdropPath = ""
    @objc dynamic var r_popularity = 0.0
    @objc dynamic var r_voteCount = 0
    @objc dynamic var r_video = false
    @objc dynamic var r_voteAverage = 0.0
    override static func primaryKey() -> String? {
        return "r_id"
    }
}

protocol MoviesRepository {
    func getMostPopular(_ completion:@escaping (GetMostPopularResult) -> Void)
    func getUpcoming(_ completion:@escaping (GetUpcomingResult) -> Void)
    func getTopRated(_ completion:@escaping (GetTopRatedResult) -> Void)
    func getSearch(searchText: String, _ completion:@escaping (GetSearchResult) -> Void)
    func save(mostPopular: MostPopularServiceModel)
    func save(upcoming: UpcomingModel)
    func save(topRated: TopRatedServiceModel)
}
class RealmMoviesRepository: MoviesRepository {
    
    private var database: Realm?
    
    init() {
        do {
            database = try Realm()
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func getMostPopular(_ completion:@escaping (GetMostPopularResult) -> Void) {
        let results: Results<RealmMostPopular>? =   database?.objects(RealmMostPopular.self)
        completion(.success(popularMovies: parse(results: results)))
    }
    
    func getUpcoming(_ completion:@escaping (GetUpcomingResult) -> Void) {
        let results: Results<RealmUpcoming>? =   database?.objects(RealmUpcoming.self)
        completion(.success(upcoming: parse(results: results)))
    }
    
    func getTopRated(_ completion:@escaping (GetTopRatedResult) -> Void) {
        let results: Results<RealmTopRated>? =   database?.objects(RealmTopRated.self)
        completion(.success(topRated: parse(results: results)))
    }
    
    func getSearch(searchText: String, _ completion:@escaping (GetSearchResult) -> Void) {
        let results = database?.objects(RealmMovieResults.self).filter("r_title contains[c] %@", searchText)
        completion(.success(search: parse(result: results)))
    }
    
    func save(mostPopular: MostPopularServiceModel) {
        let object: RealmMostPopular = parseToRealm(results: mostPopular)
        try! database?.write {
            database?.add(object, update: true)
        }
    }
    
    func save(upcoming: UpcomingModel) {
        let object: RealmUpcoming = parseToRealm(results: upcoming)
        try! database?.write {
            database?.add(object, update: true)
        }
    }
    
    func save(topRated: TopRatedServiceModel) {
        let object: RealmTopRated = parseToRealm(results: topRated)
        try! database?.write {
            database?.add(object, update: true)
        }
    }
    
    func parse(results: Results<RealmMostPopular>?) -> MostPopularServiceModel {
        var newMovies = MostPopularServiceModel(page: 0, total_results: 0, total_pages: 0, results: [])
        guard let results = results else { return newMovies }
        for result in results {
            newMovies.page = result.r_page
            newMovies.total_results = result.r_total_results
            newMovies.total_pages = result.r_total_pages
            newMovies.results = parseMoviesFromRealm(movies: result.r_results)
        }
        return newMovies
    }
    
    func parse(results: Results<RealmTopRated>?) -> TopRatedServiceModel {
        var newMovies = TopRatedServiceModel(page: 0, total_results: 0, total_pages: 0, results: [])
        guard let results = results else { return newMovies }
        for result in results {
            newMovies.page = result.r_page
            newMovies.total_results = result.r_total_results
            newMovies.total_pages = result.r_total_pages
            newMovies.results = parseMoviesFromRealm(movies: result.r_results)
        }
        return newMovies
    }
    
    func parse(results: Results<RealmUpcoming>?) -> UpcomingModel {
        var newMovies = UpcomingModel(page: 0, total_results: 0, total_pages: 0, results: [])
        guard let results = results else { return newMovies }
        for result in results {
            newMovies.page = result.r_page
            newMovies.total_results = result.r_total_results
            newMovies.total_pages = result.r_total_pages
            newMovies.results = parseMoviesFromRealm(movies: result.r_results)
        }
        return newMovies
    }
    
    func parse(result: Results<RealmMovieResults>?) -> SearchServiceModel {
        var newMovies = SearchServiceModel(page: 0, total_results: 0, total_pages: 0, results: [])
        guard let result = result else { return newMovies }
            newMovies.page = 0
            newMovies.total_results = 0
            newMovies.total_pages = 0
            newMovies.results = parseMoviesFromRealm(movies: result)
        return newMovies
    }
    
    func parseToRealm(results: MostPopularServiceModel) -> RealmMostPopular {
        let object: RealmMostPopular = RealmMostPopular()
        
        object.r_page = results.page
        object.r_total_pages = results.total_pages
        object.r_total_results = results.total_results
        object.r_results = parseMoviesToRealm(movies: results.results)
        
        return object
    }
    
    func parseToRealm(results: UpcomingModel) -> RealmUpcoming {
        let object: RealmUpcoming = RealmUpcoming()
        
        object.r_page = results.page
        object.r_total_pages = results.total_pages
        object.r_total_results = results.total_results
        object.r_results = parseMoviesToRealm(movies: results.results)
        
        return object
    }
    
    func parseToRealm(results: TopRatedServiceModel) -> RealmTopRated {
        let object: RealmTopRated = RealmTopRated()
        
        object.r_page = results.page
        object.r_total_pages = results.total_pages
        object.r_total_results = results.total_results
        object.r_results = parseMoviesToRealm(movies: results.results)
        
        return object
    }
    
    func parseMoviesToRealm(movies: [VideoDetailsModel]) -> List<RealmMovieResults> {
        
        let objects: List<RealmMovieResults> = List<RealmMovieResults>()
        
        for movie in movies {
            let object: RealmMovieResults = RealmMovieResults()
            object.r_id = movie.id
            object.r_adult = movie.adult
            object.r_posterPath = movie.posterPath ?? ""
            object.r_budget = movie.budget ?? 0
            object.r_overview = movie.overview
            object.r_releaseDate = movie.releaseDate ?? ""
            object.r_originalTitle = movie.originalTitle
            object.r_originalLanguage = movie.originalLanguage
            object.r_title = movie.title
            object.r_backdropPath = movie.backdropPath ?? ""
            object.r_popularity = movie.popularity
            object.r_voteCount = movie.voteCount
            object.r_video = movie.video
            object.r_voteAverage = movie.voteAverage
            objects.append(object)
        }
        
        return objects
    }
    
    func parseMoviesFromRealm(movies: List<RealmMovieResults>) -> [VideoDetailsModel] {
        
        var objects: [VideoDetailsModel] = [VideoDetailsModel]()
        
        for movie in movies {
            let object: VideoDetailsModel = VideoDetailsModel(
                posterPath: movie.r_posterPath,
                adult: movie.r_adult,
                budget: movie.r_budget,
                overview: movie.r_overview,
                releaseDate: movie.r_releaseDate,
                genreIds: [1,2],
                id: movie.r_id,
                originalTitle: movie.r_originalTitle,
                originalLanguage: movie.r_originalLanguage,
                title: movie.r_title,
                backdropPath: movie.r_backdropPath,
                popularity: movie.r_popularity,
                voteCount: movie.r_voteCount,
                video: movie.r_video,
                voteAverage: movie.r_voteAverage
            )
            objects.append(object)
        }
        
        return objects
    }
    
    func parseMoviesFromRealm(movies: Results<RealmMovieResults>) -> [VideoDetailsModel] {
        
        var objects: [VideoDetailsModel] = [VideoDetailsModel]()
        
        for movie in movies {
            let object: VideoDetailsModel = VideoDetailsModel(
                posterPath: movie.r_posterPath,
                adult: movie.r_adult,
                budget: movie.r_budget,
                overview: movie.r_overview,
                releaseDate: movie.r_releaseDate,
                genreIds: [1,2],
                id: movie.r_id,
                originalTitle: movie.r_originalTitle,
                originalLanguage: movie.r_originalLanguage,
                title: movie.r_title,
                backdropPath: movie.r_backdropPath,
                popularity: movie.r_popularity,
                voteCount: movie.r_voteCount,
                video: movie.r_video,
                voteAverage: movie.r_voteAverage
            )
            objects.append(object)
        }
        
        return objects
    }
    
    
}
