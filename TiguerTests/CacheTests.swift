//
//  CacheTests.swift
//  TiguerTests
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer
import Cache

class CacheTests: XCTestCase {
    
    let testKey = "test"
    let testInt = 5
    let set: Set<Int> = [5]
    
    func testAddObjectToCache() {
        let cache = BaseCache<Set<Int>>()
        cache.setObject(set, key: testKey)
        let cachedSet: Set<Int>? = cache.getObject(testKey)
        XCTAssertNotNil(cachedSet)
        XCTAssert(cachedSet!.contains(testInt))
    }
    
    func testAddObjectToCacheTesting() {
        let cache = BaseCache<Set<Int>>()
        cache.updateTestingState(TestingState.testing)
        cache.removeObject(testKey)
        cache.setObject(set, key: testKey)
        let cachedSet: Set<Int>? = cache.getObject(testKey)
        XCTAssertNil(cachedSet)
    }
    
    func testRemoveObjectFromCache() {
        let cache = BaseCache<Set<Int>>()
        cache.setObject(set, key: testKey)
        cache.removeObject(testKey)
        let cachedSet: Set<Int>? = cache.getObject(testKey)
        XCTAssertNil(cachedSet)
    }
}
