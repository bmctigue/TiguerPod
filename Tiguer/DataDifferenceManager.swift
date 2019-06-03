//
//  DataDifferenceManager.swift
//  Tiguer
//
//  Created by Bruce McTigue on 6/3/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import DifferenceKit

final class CollectionViewDataDifferenceManager<Model:Differentiable> {
    
    private var collectionView: UICollectionView!
    
    private var currentData = [Model]()
    public var data: [Model] {
        get { return currentData }
        set {
            let changeset = StagedChangeset(source: currentData, target: newValue)
            collectionView.reload(using: changeset) { updatedData in
                self.currentData = updatedData
            }
        }
    }
    
    public init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
}
