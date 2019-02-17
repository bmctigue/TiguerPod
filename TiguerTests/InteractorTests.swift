//
//  MoviesInteractorTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 1/4/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
import Promis
@testable import Tiguer

class MoviesInteractorTests: XCTestCase {
    
    let assetName = "testJson"
    let cacheKey = "movies"
    
    func testFetchItemsForAllMovies() {
        let testBundle = Bundle(for: type(of: self))
        let store = LocalStore(assetName, bundle: testBundle)
        let dataAdapter = TestDataAdapter<TiguerMovie>()
        let service = Tiguer.Service<TiguerMovie, Tiguer.DataAdapter>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
        let presenter = TestPresenter<TiguerMovie, TiguerMovieViewModel>([], main: SyncQueue.global, background: SyncQueue.background)
        let sut = Tiguer.Interactor<TiguerMovie, TestPresenter, Tiguer.Service>(presenter, service: service)
        let request = Request()
        let url = URL(string: "https://www.google.com")!
        sut.fetchItems(request, url: url)
        let dynamicModels = presenter.getDynamicModels()
        XCTAssertNotNil(dynamicModels.value.count == 1)
    }
}
