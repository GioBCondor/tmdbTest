//
//  mostPopularModel.swift
//  MoviesTest
//
//  Created by Camilo López on 5/14/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

struct MostPopularServiceModel: Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [VideoDetailsModel]
}
