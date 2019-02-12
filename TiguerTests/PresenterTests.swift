//
//  MoviesPresenterTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer

class TestPresenter<Model, ViewModel: Comparable, Filter: FilterProtocol>: Tiguer.Presenter<Model, ViewModel, Filter> {
    
    override var baseViewModels: [ViewModel] {
        var resultModels = [ViewModel]()
        for _ in models {
            let displayedModel = SampleViewModel(sampleId: 0) as! ViewModel
            resultModels.append(displayedModel)
        }
        return resultModels
    }
}

class TestFilter: FilterProtocol {
    typealias ViewModel = SampleViewModel
    func filter<ViewModel:Comparable>(_ viewModels: [ViewModel]) -> [ViewModel] {
        return viewModels
    }
}

class PresenterTests: XCTestCase {
    
    let models = ["Test1","Test2"]
    
    func testDisplayedMovies() {
        let sut = TestPresenter<String, SampleViewModel, TestFilter>([], filter: nil, main: SyncQueue.global, background: SyncQueue.background)
        sut.updateViewModelsInBackground()
        XCTAssert(sut.getDynamicModels().value.count == 0)
    }
    
    func testInitWithDisplayedMovies() {
        let filter = TestFilter()
        let sut = TestPresenter<String, SampleViewModel, TestFilter>(models, filter: filter, main: SyncQueue.global, background: SyncQueue.background)
        sut.updateViewModelsInBackground()
        XCTAssert(sut.getDynamicModels().value.count == models.count)
    }

    func testUpdateDisplayedMovies() {
        let filter = TestFilter()
        let sut = TestPresenter<String, SampleViewModel, TestFilter>(models, filter: filter, main: SyncQueue.global, background: SyncQueue.background)
        let response = Response(models)
        sut.updateViewModels(response)
        let dynamicModels = sut.getDynamicModels()
        XCTAssert(dynamicModels.value.count == 2)
    }

    func testGetModels() {
        let filter = TestFilter()
        let sut = TestPresenter<String, SampleViewModel, TestFilter>(models, filter: filter, main: SyncQueue.global, background: SyncQueue.background)
        XCTAssert(sut.getModels().count == models.count)
    }
}
