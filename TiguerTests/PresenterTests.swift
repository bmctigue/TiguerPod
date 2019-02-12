//
//  MoviesPresenterTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer

class TestPresenter<Model, ViewModel: Comparable>: Tiguer.Presenter<Model, ViewModel> {
    
    override var baseViewModels: [ViewModel] {
        var resultModels = [ViewModel]()
        for _ in models {
            let displayedModel = SampleViewModel(sampleId: 0) as! ViewModel
            resultModels.append(displayedModel)
        }
        return resultModels
    }
}

class PresenterTests: XCTestCase {
    
    let models = ["Test1","Test2"]
    
    func testDisplayedMovies() {
        let sut = TestPresenter<String, SampleViewModel>([], main: SyncQueue.global, background: SyncQueue.background)
        sut.updateViewModelsInBackground()
        XCTAssert(sut.getDynamicModels().value.count == 0)
    }
    
    func testInitWithDisplayedMovies() {
        let sut = TestPresenter<String, SampleViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        sut.updateViewModelsInBackground()
        XCTAssert(sut.getDynamicModels().value.count == models.count)
    }

    func testUpdateDisplayedMovies() {
        let sut = TestPresenter<String, SampleViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        let response = Response(models)
        sut.updateViewModels(response)
        let dynamicModels = sut.getDynamicModels()
        XCTAssert(dynamicModels.value.count == 2)
    }

    func testGetModels() {
        let sut = TestPresenter<String, SampleViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        XCTAssert(sut.getModels().count == models.count)
    }
}
