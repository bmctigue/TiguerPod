//
//  Protocols.swift
//  Tiguer
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Promis

typealias VCBuilderBlock = ((UIViewController) -> Void)
typealias TabBarBuilderBlock = ((UITabBarController) -> Void)

public let forceKey = "force"

protocol BaseBuilder: class {
    func run()
}

protocol VCBuilder: class {
    func run(completionHandler: VCBuilderBlock)
}

protocol StoreProtocol {
    func fetchData(_ url: URL) -> Future<Store.Result>
}

protocol DataAdapterProtocol {
    associatedtype Model
    func itemsFromData(_ data: Data, completionHandler: @escaping (DataAdapter.Result<Model>) -> Void)
}

protocol InteractorProtocol: class {
    func fetchItems(_ request: Request)
}

protocol PresenterProtocol {
    associatedtype Model
    associatedtype ViewModel
}

protocol NetworkSession {
    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

protocol URLGenerator {
    func url() -> URL?
    func queryItemsFromRequest(_ request: Request) -> [URLQueryItem]?
}

extension URLGenerator {
    func queryItemsFromRequest(_ request: Request) -> [URLQueryItem]? {
        guard !request.params.isEmpty else {
            return nil
        }
        var queryItems = [URLQueryItem]()
        for (key, value) in request.params where key != forceKey {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        return queryItems
    }
}
