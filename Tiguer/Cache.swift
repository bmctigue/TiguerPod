//
//  Cache.swift
//  Tiguer
//
//  Created by Bruce McTigue on 2/4/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import NKCache

extension Tiguer {
    open class BaseCache<CacheObject: Codable>: CacheProtocol {
        
        private var testingState: TestingState = .notTesting
        private var storage: NKCacheManager
        
        public init() {
            self.storage = NKCacheManager.sharedInstance
        }
        
        public func setObject<CacheObject: Codable>(_ object: CacheObject, forKey key: String) {
            guard testingState == .notTesting else {
                return
            }
            storage.setObject((object as CacheObject), forKey: key)
        }
        
        public func getObjectForKey<CacheObject>(_ key: String, completionHandler: @escaping (CacheObject?) -> ()) where CacheObject : Decodable, CacheObject : Encodable {
            storage.getObjectForKey(key) { (object: CacheObject?) in
                completionHandler(object)
            }
        }
        
        public func removeObjectForKey(_ key: String) {
            storage.removeObjectForKey(key)
        }
        
        public func updateTestingState(_ testingState: TestingState) {
            self.testingState = testingState
        }
    }
}
