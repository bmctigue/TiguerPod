//
//  SelectionManagerTests.swift
//  TiguerTests
//
//  Created by Bruce McTigue on 2/26/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer

struct SelectionModel {
    var id: String
}

class SelectionManagerTests: XCTestCase {
    
    let model = SelectionModel(id: "0")
    
    func testUpdateFavorites() {
        let manager = Tiguer.SelectionManager<SelectionModel>()
        manager.updateSelections(.selected(model.id))
        XCTAssertTrue(manager.getSelections().contains(model.id))
        
        manager.updateSelections(.unSelected(model.id))
        XCTAssertFalse(manager.getSelections().contains(model.id))
    }
}
