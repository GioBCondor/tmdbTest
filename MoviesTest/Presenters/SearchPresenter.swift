//
//  SearchPresenter.swift
//  MoviesTest
//
//  Created by Camilo López on 5/16/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation

class SearchPresenter {
    
    private let locator: UseCaseLocatorProtocol
    
    init(locator: UseCaseLocatorProtocol) {
        self.locator = locator
    }
    
    func getSearch(by keyword:String, _ completion:@escaping (GetSearchResult) -> Void) {
        guard let searchUseCase = locator.getUseCase(ofType: GetSearch.self) else {
            return
        }
        searchUseCase.get(by: keyword, completion)
    }
}
