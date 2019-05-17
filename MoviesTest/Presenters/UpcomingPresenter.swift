//
//  UpcomingPresenter.swift
//  MoviesTest
//
//  Created by Camilo López on 5/16/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

class UpcomingPresenter {
    
    private let locator: UseCaseLocatorProtocol
    
    init(locator: UseCaseLocatorProtocol) {
        self.locator = locator
    }
    
    func getUpcoming(_ completion:@escaping (GetUpcomingResult) -> Void) {
        guard let upcomingUseCase = locator.getUseCase(ofType: GetUpcoming.self) else {
            return
        }
        upcomingUseCase.get(completion)
    }
}
