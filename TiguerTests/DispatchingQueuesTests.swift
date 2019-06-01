//
//  DispatchingQueuesTests.swift
//  TiguerTests
//
//  Created by Bruce McTigue on 6/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer

class DispatchingQueuesTests: XCTestCase {

    var dictionary: [String:Int] = Dictionary()
    let key = "key"
    let value = 100
    
    override func setUp() {
        dictionary = Dictionary()
    }
    
    func testAsyncMain() {
        let expectation = self.expectation(description: "addObserver")
        var result = 0
        AsyncQueue.main.dispatch { [weak self] in
            if let self = self {
                self.dictionary[self.key] = self.value
                AsyncQueue.main.dispatch {
                    result = self.dictionary[self.key] ?? 0
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(result == value)
    }
    
    func testAsyncGlobal() {
        let expectation = self.expectation(description: "addObserver")
        var result = 0
        AsyncQueue.global.dispatch { [weak self] in
            if let self = self {
                self.dictionary[self.key] = self.value
                AsyncQueue.global.dispatch {
                    result = self.dictionary[self.key] ?? 0
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(result == value)
    }
    
    func testAsyncBackground() {
        let expectation = self.expectation(description: "addObserver")
        var result = 0
        AsyncQueue.background.dispatch { [weak self] in
            if let self = self {
                self.dictionary[self.key] = self.value
                AsyncQueue.background.dispatch {
                    result = self.dictionary[self.key] ?? 0
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(result == value)
    }

    func testSyncGlobal() {
        var result = 0
        SyncQueue.global.dispatch { [weak self] in
            if let self = self {
                self.dictionary[self.key] = self.value

            }
        }
        SyncQueue.global.dispatch {
            result = self.dictionary[self.key] ?? 0
        }
        XCTAssert(result == value)
    }

    func testSyncBackground() {
        var result = 0
        SyncQueue.background.dispatch { [weak self] in
            if let self = self {
                self.dictionary[self.key] = self.value
            }
        }
        SyncQueue.background.dispatch {
            result = self.dictionary[self.key] ?? 0
        }
        XCTAssert(result == value)
    }
    
    func testAsyncSafeQueue() {
        let expectation = self.expectation(description: "addObserver")
        var result = 0
        SafeQueue.instance.asyncDispatch { [weak self] in
            if let self = self {
                self.dictionary[self.key] = self.value
                SafeQueue.instance.asyncDispatch {
                    result = self.dictionary[self.key] ?? 0
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(result == value)
    }

    func testSyncSafeQueue() {
        var result = 0
        SafeQueue.instance.syncDispatch { [weak self] in
            if let self = self {
                self.dictionary[self.key] = self.value
            }
        }
        SafeQueue.instance.syncDispatch {
            result = self.dictionary[self.key] ?? 0
        }
        XCTAssert(result == value)
    }
}
