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
    
    let testKey = "test"
    let testInt = 5
    let set: Set<Int> = [5]
    
    func testAddObjectToCache() {
        let cache = Tiguer.BaseCache<CacheObject>()
        cache.setObject(set, forKey: testKey)
        let result = cache.getObjectForKey(testKey) ?? CacheObject()
        XCTAssert(!result.isEmpty)
        XCTAssert(result.contains(self.testInt))
    }
    
    func testAddObjectToCacheTesting() {
        let cache = Tiguer.BaseCache<CacheObject>()
        cache.updateTestingState(TestingState.testing)
        cache.removeObjectForKey(testKey)
        cache.setObject(set, forKey: testKey)
        let result = cache.getObjectForKey(testKey) ?? CacheObject()
        XCTAssert(result.count == 0)
    }
    
    func testRemoveObjectFromCache() {
        let cache = Tiguer.BaseCache<CacheObject>()
        cache.setObject(set, forKey: testKey)
        cache.removeObjectForKey(testKey)
        let result = cache.getObjectForKey(testKey) ?? CacheObject()
        XCTAssert(result.count == 0)
    }
}
