//
//  LocalDataUrlGenerator.swift
//  RicosCafe
//
//  Created by Bruce McTigue on 2/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

class LocalDataUrlGenerator: URLGenerator {
    
    private lazy var components: URLComponents = URLComponents()
    
    init(_ request: Request) {
        self.components.host = "www.google.com"
        self.components.path = ""
        self.components.scheme = "https"
    }
    
    func url() -> URL? {
        return components.url
    }
}
