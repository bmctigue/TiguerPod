//
//  StoryboardFactoryTests.swift
//  TiguerTests
//
//  Created by Bruce McTigue on 2/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer

class StoryboardFactoryTests: XCTestCase {
    
    func testStoryBoardFactory() {
        let factory = StoryboardFactory()
        let testBundle = Bundle(for: type(of: self))
        let storyboard = factory.create(name: "Test", bundle: testBundle)
        XCTAssert(storyboard.isKind(of: UIStoryboard.self))
    }
}
