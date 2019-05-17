//
//  TopRatedPresenter.swift
//  MoviesTest
//
//  Created by Camilo López on 5/16/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

class TopRatedPresenter {
    
    private let locator: UseCaseLocatorProtocol
    
    init(locator: UseCaseLocatorProtocol) {
        self.locator = locator
    }
    
    func getTopRated(_ completion:@escaping (GetTopRatedResult) -> Void) {
        guard let topRatedUseCase = locator.getUseCase(ofType: GetTopRated.self) else {
            return
        }
        topRatedUseCase.get(completion)
    }
}
