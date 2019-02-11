//
//  MoviesPresenterTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer

struct TestViewModel {
    let testId: Int
    init(testId: Int) {
        self.testId = testId
    }
}

class TestPresenter<Model, ViewModel>: Tiguer.Presenter<Model, ViewModel> {
    override var baseViewModels: [ViewModel] {
        var resultModels = [ViewModel]()
        for _ in models {
            let displayedModel = TestViewModel(testId: 0) as! ViewModel
            resultModels.append(displayedModel)
        }
        return resultModels
    }
}

class PresenterTests: XCTestCase {
    
    typealias Model = String
    typealias ViewModel = TestViewModel
    
    let model1: Model = "Test1"
    let model2: Model = "Test2"
    
    func testDisplayedMovies() {
        let sut = TestPresenter<Model, ViewModel>([], main: SyncQueue.global, background: SyncQueue.background)
        sut.updateViewModelsInBackground()
        XCTAssert(sut.getDynamicModels().value.count == 0)
    }
    
    func testInitWithDisplayedMovies() {
        let models = [model1,model2]
        let sut = TestPresenter<Model, ViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        sut.updateViewModelsInBackground()
        XCTAssert(sut.getDynamicModels().value.count == models.count)
    }

    func testUpdateDisplayedMovies() {
        let models = [model1,model2]
        let sut = TestPresenter<Model, ViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        let response = Response(models)
        sut.updateViewModels(response)
        let dynamicModels = sut.getDynamicModels()
        XCTAssert(dynamicModels.value.count == 2)
    }

    func testGetModels() {
        let models = [model1,model2]
        let sut = TestPresenter<Model, ViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        XCTAssert(sut.getModels().count == models.count)
    }
}
