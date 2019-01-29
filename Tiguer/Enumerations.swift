//
//  Enumerations.swift
//  Tiguer
//
//  Created by Bruce McTigue on 1/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

enum TestingState {
    case testing
    case notTesting
}

enum MovieFavoriteState: Equatable {
    case selected(Int)
    case unSelected(Int)
}

enum StoreError: Error {
    case fetchDataFailed
}

enum Store {
    enum Result {
        case success(Data)
    }
}

enum DataAdapterError: Error {
    case conversionFailed
}

enum DataAdapter {
    enum Result<Model> {
        case success([Model])
    }
}
