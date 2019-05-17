//
//  MostPopularPresenter.swift
//  MoviesTest
//
//  Created by Camilo López on 5/15/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

class MostPopularPresenter {
    
    private let locator: UseCaseLocatorProtocol
    
    init(locator: UseCaseLocatorProtocol) {
        self.locator = locator
    }
    
    func getMostPopular(_ completion:@escaping (GetMostPopularResult) -> Void) {
        guard let mostPopularUseCase = locator.getUseCase(ofType: GetMostPopular.self) else {
            return
        }
        mostPopularUseCase.get(completion)
    }
}
