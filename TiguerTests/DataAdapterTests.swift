//
//  DataAdapterTests.swift
//  TiguerTests
//
//  Created by Bruce McTigue on 2/13/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
import Tiguer
import Promis

class TestDataAdapter<String>: Tiguer.DataAdapter<String> {
    override func itemsFromData(_ data: Data) -> Future<DataAdapterResult.Result<Model>> {
        let promise = Promise<DataAdapterResult.Result<Model>>()
        do {
            let results = [Model]()
            promise.setResult(.success(results))
        }
        return promise.future
    }
}

class DataAdapterTests: XCTestCase {

    func testItemsFromData() {
        let sut = TestDataAdapter<String>()
        let result = sut.itemsFromData(Data())
        XCTAssert(result.hasResult())
    }
}
