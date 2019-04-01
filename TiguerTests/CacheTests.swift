//
//  CacheTests.swift
//  TiguerTests
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer

class CacheTests: XCTestCase {
    
    typealias CacheObject = Set<Int>
    
    let testKey = NSString("test")
    let testInt = 5
    let set: Set<Int> = [5]
    
    func testAddObjectToCache() {
        let cache = TestCache()
        cache.setObject(set, key: testKey)
        let cachedSet: CacheObject? = cache.getObject(testKey)
        XCTAssertNotNil(cachedSet)
        XCTAssert(cachedSet!.contains(testInt))
    }
    
    func testAddObjectToCacheTesting() {
        let cache = TestCache()
        cache.updateTestingState(TestingState.testing)
        cache.removeObject(testKey)
        cache.setObject(set, key: testKey)
        let cachedSet: CacheObject? = cache.getObject(testKey)
        XCTAssertNil(cachedSet)
    }
    
    func testRemoveObjectFromCache() {
        let cache = TestCache()
        cache.setObject(set, key: testKey)
        cache.removeObject(testKey)
        let cachedSet: CacheObject? = cache.getObject(testKey)
        XCTAssertNil(cachedSet)
    }
}

class TestCache: Tiguer.BaseCache {
    typealias CacheObject = Set<Int>
}
