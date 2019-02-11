//
//  RemoteStoreTests.swift
//  TiguerTests
//
//  Created by Bruce McTigue on 1/14/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
import Promis
@testable import Tiguer

class RemoteStoreTests: XCTestCase {

    var resultFuture: Future<Store.Result>?
    var error: StoreError?
    let url = URL(string: "https://www.google.com")!
    lazy var config = URLSessionConfiguration.ephemeral
    var session: URLSession!
    var sut: StoreProtocol!
    
    override func setUp() {
        URLProtocolStub.testURLs = [url: Data()]
        config.protocolClasses = [URLProtocolStub.self]
        self.session = URLSession(configuration: config)
        self.sut = RemoteStore(session: session)
    }
    
    func testRemoteStoreFetchData() {
        let expectation = self.expectation(description: "fetchData")
        let testBundle = Bundle(for: type(of: self))
        sut.fetchData(url, bundle: testBundle).finally { [weak self] future in
            switch future.state {
            case .result(let storeResult):
                switch storeResult {
                case .success(_):
                    self?.resultFuture = future
                }
            case .error(let error):
                print(error)
                XCTFail()
            case .cancelled:
                XCTFail()
            case .unresolved:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(self.resultFuture)
        XCTAssertNil(error)
    }
}
