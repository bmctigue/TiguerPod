//
//  Presenter.swift
//  Tiguer
//
//  Created by Bruce McTigue on 2/11/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

extension Tiguer {
    open class Presenter<Model, ViewModel, Filter: FilterProtocol>: PresenterProtocol {
        
        public var models: [Model]
        public var viewModels: [ViewModel] = []
        private var dynamicModels: DynamicValue<[ViewModel]> = DynamicValue([ViewModel]())
        
        public var filter: Filter?
        public var main: Dispatching
        public var background: Dispatching
        
        
        public init(_ models: [Model] = [Model](), filter: Filter?, main: Dispatching = AsyncQueue.main, background: Dispatching = AsyncQueue.background) {
            self.models = models
            self.main = main
            self.background = background
            self.viewModels = baseViewModels
            self.filter = filter
        }
        
        open var baseViewModels: [ViewModel] {
            assert(false, "Presenter baseViewModels is not implemented")
            return []
        }
        
        open func updatedViewModels(completionHandler: @escaping ([ViewModel]) -> Void) {
            background.dispatch {
                var resultModels = self.viewModels
                if let filter = self.filter {
                    resultModels = filter.filter(resultModels)
                }
                self.main.dispatch {
                    completionHandler(resultModels)
                }
            }
        }
        
        public func updateViewModels(_ response: Response<Model>) {
            self.models = response.models
            self.viewModels = baseViewModels
            self.updateViewModelsInBackground()
        }
        
        public func updateViewModelsInBackground() {
            updatedViewModels { [weak self] results in
                self?.dynamicModels.value = results
            }
        }
        
        public func getDynamicModels() -> DynamicValue<[ViewModel]> {
            return dynamicModels
        }
        
        func getModels() -> [Model] {
            return models
        }
    }
}
