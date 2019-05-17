//
//  Constants.swift
//  MoviesTest
//
//  Created by Camilo López on 5/14/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

struct Constants {
    public static let baseURL = "https://api.themoviedb.org/4"
    public static let mostPopularEndPoint = "/discover/movie?sort_by=popularity.desc"
    public static let upcomingEndPoint = "/discover/movie?sort_by=primary_release_date.desc"
    public static let topRatedEndPoint = "/discover/movie?sort_by=vote_average.desc"
    public static let searchEndPoint = "/search/movie?query="
    public static let movieDetails = "/movie/{movie_id}"
    public static let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjM2UwNjg5ODIwMjE5MWRlNWVjNDBiNDljYTliNWQ5MSIsInN1YiI6IjVjZGI3NWJlMGUwYTI2MmQxMGNhZGE4NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._9UrRPXi2JdHUofUB2snwlq74KybNabi9AC3KwJs4xY"
    
    
    struct RequestTimeOutConstants {
        static let defaultTimeOut: Double = 60
    }
}

